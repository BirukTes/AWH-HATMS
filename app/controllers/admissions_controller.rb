class AdmissionsController < ApplicationController
  # Sets the admission object for the following actions
  before_action(:set_admission, only: [:show, :edit, :update, :destroy, :discharge, :authorise_discharge])

  # Authorisation callbacks
  # Make sure all actions perform authorisation, (individual records),
  # index retrieves multiple records so exclude
  after_action(:verify_authorized)

  # Verify authorisation for all admissions (multiple records), which index only does
  # after_action(:verify_policy_scoped, only: :index)

  def index
    authorize(:admission)

    # TODO CONVERT TO ransack
    # ! Inverts the blank => false, not blank => true
    @admissions = if !params[:filter_admission_by_status].blank? && !params[:filter_admission_by_status].eql?('All') &&
        params[:filter_admission_by_date].blank?
                    Admission.where(status: params[:filter_admission_by_status].downcase).all

                  elsif (!params[:filter_admission_by_status].blank? && !params[:filter_admission_by_status].eql?('All')) && !params[:filter_admission_by_date].blank?
                    # FIXME only returns nil
                    Admission.where('"admissionDate" >= ? AND "status" = ?', params[:filter_admission_by_date], params[:filter_admission_by_status].downcase).all

                  elsif params[:filter_admission_by_status].eql?('All') && !params[:filter_admission_by_date].blank?
                    Admission.where('"admissionDate" >= ? AND', params[:filter_admission_by_date])

                  elsif !params[:filter_admission_by_date].blank?
                    Admission.where('"admissionDate" >= ?', params[:filter_admission_by_date]).all

                  elsif params[:filter_admission_by_status].eql?('All')
                    Admission.all
                  else
                    Admission.admitted
                  end

    # This method is aware of what format to respond with (as declared above, js, html, json)
    respond_with(@admissions)
  end

  def show;
  end

  def new
    authorize(:admission)
    @admission = Admission.new

    if params.key?(:dateOfBirth) && !params[:dateOfBirth].blank?
      params.key?(:lastName) && !params[:lastName].blank? && @patient.eql?(nil)

      @patient = Patient.find_patient(params[:dateOfBirth], params[:lastName])

      if @patient.nil?
        flash[:alert] = 'Patient not found'
      else
        if Admission.admitted?(@patient.id)
          @patient = nil
          flash[:alert] = 'Patient is already admitted.'
        end
      end
    elsif params.include?(:rest_patient)
      @patient = nil
    else
      if params.key?(:dateOfBirth) && params.key?(:lastName)
        flash[:alert] = case params[:dateOfBirth].blank? || params[:lastName].blank?
                          when params[:dateOfBirth].blank?
                            'Please fill in the date of birth.'
                          when params[:lastName].blank?
                            'Please fill in the last name.'
                          else
                            'Please fill in the all fields.'
                        end
      end
    end

  end

  def create
    authorize(:admission)
    @admission = Admission.new(admission_params)

    # binding.pry # break point Pry Debugger
    # Validation, FIXME
    if @admission.valid?
      # Admitted, Discharged
      @admission.status = 'Admitted'
    end

    respond_to do |format|
      # It is important to check it save it
      if @admission.save
        # Update the bed status with new value if it nil or 0, otherwise continue to decrement it current value
        @admission.ward.update(bedStatus: if @admission.ward.bedStatus.nil? || @admission.ward.bedStatus == 0
                                            @admission.ward.numberOfBeds - 1
                                          else
                                            @admission.ward.bedStatus - 1
                                          end)

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

  # Discharges patient now/today
  def destroy
    # Admitted / Discharged
    @admission.dischargeDate = Time.now
    @admission.status = 'Discharged'

    if @admission.save!
      # Return the one bed, and update the ward bedStatus
      # Check for max, in case goes above actual number
      @admission.ward.update(bedStatus: if @admission.ward.bedStatus >= @admission.ward.numberOfBeds
                                          # Don't add anything, already max?
                                          0
                                        else
                                          @admission.ward.bedStatus + 1
                                        end)
      redirect_to(admissions_path, notice: 'Patient discharged')
    end
  end

  # Finds patient to discharge
  def find_and_discharge
    authorize(:admission)
    if params.include?(:ward_id) && params.include?(:patient_id) && @patient.eql?(nil)
      @admission = Admission.where(patient_id: params[:patient_id], ward_id: params[:ward_id]).first
      if @admission
        # respond_modal_with(@admission, location: discharge_admission_path(@admission.id))
        redirect_to(discharge_admission_path(@admission.id))
      end
    elsif params.include?(:rest_patient)
      @patient = nil
    end
  end

  # Displays discharge modal/dialog
  def discharge
    respond_modal_with(@admission)
  end

  # Authorises discharge
  def authorise_discharge
    if !params[:admission][:dischargeDate].blank?
      if @admission.update(dischargeDate: params[:admission][:dischargeDate])
        Admission.delay(run_at: @admission.dischargeDate).set_status_discharge(@admission.id)
        redirect_to(admissions_path, notice: 'Successful discharge authorisation.')
      else
        # In case of error
        render(:discharge)
      end
    else
      # TODO modal not working
      # respond_modal_with(@admission, location: discharge_admission_path(@admission.id))
      render(:discharge)
    end
  end

  def search
    authorize(:admission)
    redirect_to(reports_ward_list_path)
  end

  # Private methods
  private

  # @return [params]
  def admission_params
    params.require(:admission).permit(:id, :admissionDate, :dischargeDate, :currentMedications, :admissionNote,
                                      :ward_id, :patient_id, :dateOfBirth, :lastName, :ward_id_selected,
                                      :filter_admission_by_status, :filter_admission_by_date)
  end


  # @return [admission]
  def set_admission
    authorize(:admission)
    @admission = Admission.find(params[:id])
  end
end