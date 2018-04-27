class AdmissionsController < ApplicationController
  # Sets the admission object for the following actions
  before_action(:set_admission, only: [:show, :edit, :update, :destroy, :discharge])

  # This defines the responses types, or It is referencing the response that will
  # be sent to the View (which is going to the browser) https://stackoverflow.com/a/9492463/5124710
  respond_to :html, :json, :js

  def index
    @admissions = Admission.all
  end

  def show;
  end

  def new
    @admission = Admission.new

    if params.key?(:dateOfBirth) && !params[:dateOfBirth].blank?
      params.key?(:lastName) && !params[:lastName].blank? && @patient.eql?(nil)

      @patient = Patient.find_patient(params[:dateOfBirth], params[:lastName])

      if @patient.nil?
        @errors = ['Patient not found']
      else
        if Admission.admitted?(@patient.id)
          @patient = nil
          @errors = ['Patient is already admitted.']
        end
      end
    elsif params.include?(:rest_patient)
      @patient = nil
    else
      if params.key?(:dateOfBirth) && params.key?(:lastName)
        @errors = case params[:dateOfBirth].blank? || params[:lastName].blank?
                    when params[:dateOfBirth].blank?
                      ['Please fill in the date of birth.']
                    when params[:lastName].blank?
                      ['Please fill in the last name.']
                    else
                      ['Please fill in the all fields.']
                  end
      end
    end

    if params.key?(:ward_id_selected)
      @teams = Ward.find(params[:ward_id_selected]).teams.all
      tm_options = @teams.map do |team|
        { name: team.name, id: team.id }
      end

      respond_with(tm_options)
    end
  end

  def create
    @admission = Admission.new(admission_params)

    # Validation
    if @admission.valid?
      # Admitted, Discharged
      @admission.status = 'Admitted'
      # TODO for discharge also
      @admission.ward.bedStatus = @admission.ward.numberOfBeds - 1
    end

    respond_to do |format|
      # It is important to check it save it
      if @admission.save
        format.html { redirect_to(@admission, notice: 'Admission successful') }
        format.json { render :show, status: :created, location: @product }
      else
        # puts(@admission.inspect)
        # Pass the errors, to the instance variable, TODO errors
        format.html { render :new }
        format.json { render json: @admission.errors, status: :unprocessable_entity }
      end
    end
  end

  # @return [admission]
  def edit;
  end

  def update
    @admission = Admission.find(params[:id])

    respond_to do |format|
      if @admission.update(admission_params)
        format.html { redirect_to(@admission, notice: 'Admission update successful.') }
      else
        format.html { render(:edit) }
        format.html { render(json: @admission.errors, status: :unprocessable_entity) }
      end
    end
  end

  def destroy
    # Admitted / Discharged
    @admission.status = 'Discharged'
    @admission.save
  end

  # Private methods
  private

  # @return [params]
  def admission_params
    params.require(:admission).permit(:id, :admissionDate, :dischargeDate, :currentMedications, :admissionNote,
                                      :ward_id, :patient_id, :dateOfBirth, :lastName, :team_category, :ward_id_selected,
                                      :team_id)
  end


  # @return [admission]
  def set_admission
    @admission = Admission.find(params[:id])
  end

  def discharge
    @admission = Admission.find(params[:id])

    respond_to do |format|
      format.html { render @admission, notice: 'Successful discharge authorisation.' }
      format.js { render json: @admission }
    end
  end

  def authorise_discharge
    @admission = Admission.find(params[:id])

    respond_to do |format|
      if @admission.update(admission_params)
        format.html { render @admission, notice: 'Successful discharge authorisation.' }
        format.json { render json: @admission }
      else
        format.html { render :discharge }
        format.json { render json: @admission, status: :unprocessable_entity }
      end
    end
  end

end