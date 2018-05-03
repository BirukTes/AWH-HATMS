class AdmissionsController < ApplicationController
  # Sets the admission object for the following actions
  before_action(:set_admission, only: [:show, :edit, :update, :destroy, :discharge, :authorise_discharge])

  # This defines the responses types, or It is referencing the response that will
  # be sent to the View (which is going to the browser) https://stackoverflow.com/a/9492463/5124710
  respond_to :html, :json, :js

  # Authorisation callbacks
  # Make sure all actions perform authorisation, (individual records),
  # index retrieves multiple records so exclude
  after_action(:verify_authorized, except: :index)

  # Verify authorisation for all admissions (multiple records), which index only does
  after_action(:verify_policy_scoped, only: :index)

  def index
    @admissions = policy_scope(Admission).reverse
  end

  def show;
  end

  def new
    @admission = Admission.new
    authorize @admission

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
    authorize @admission

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
        format.html { redirect_to(admissions_path, notice: 'Admission successful') }
      else
        # puts(@admission.inspect)
        # Pass the errors, to the instance variable, TODO errors
        format.html { render :new }
      end
    end
  end

  # @return [admission]
  def edit;
  end

  def update
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
    @admission.dischargeDate = Time.now
    @admission.status = 'Discharged'

    if @admission.save!
      redirect_to(admissions_path, notice: 'Patient discharged')
    end
  end

  def find_and_discharge
    authorize @admission
    if params.include?(:ward_id) && params.include?(:patient_id) && @patient.eql?(nil)
      @admission = Admission.where(patient_id: params[:patient_id], ward_id: params[:ward_id]).first
      if @admission
        redirect_to(discharge_admission_path(@admission.id))
      end
    elsif params.include?(:rest_patient)
      @patient = nil
    end
  end

  def discharge
    respond_modal_with(@admission)
  end

  def authorise_discharge
    if @admission.update!(admission_params)
      redirect_to(admissions_path, notice: 'Successful discharge authorisation.')
    else
      respond_modal_with(@admission, location: discharge_admission_path(@admission.id))
    end
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
    authorize @admission
  end
end