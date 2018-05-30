class AdmissionsController < ApplicationController
  # Sets the admission object for the following actions
  before_action(:set_admission, only: [:show, :edit, :update, :destroy, :discharge, :authorise_discharge,
                                       :admit_scheduled, :cancel_scheduled])

  # Authorisation callbacks
  # Make sure all actions perform authorisation, (individual records),
  # index retrieves multiple records so exclude
  after_action(:verify_authorized)

  # Verify authorisation for all admissions (multiple records), which case index only has multiple
  # after_action(:verify_policy_scoped, only: :index)

  def index
    authorize(:admission)
    # Will allow to use the sorting also
    @search = Admission.ransack(params[:q])
    @admissions = @search.result.includes(:ward, :patient)

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
        # Display message for the current page
        flash.now[:alert] = 'Patient not found'
      else
        # Check if patient is has any admitted or scheduled
        # Returns a collection, evaluates the code inside if it is not nil/empty
        if @patient.admissions.admitted.size > 0
          @patient = nil
          flash.now[:alert] = 'Patient is already admitted'
        elsif @patient.admissions.scheduled.size > 0
          @patient = nil
          flash.now[:alert] = 'Patient is already scheduled'
        end
      end
    elsif params.include?(:rest_patient)
      @patient = nil
    else
      # Extra validation in case otherwise normal should not get past html required attribute
      if params.key?(:dateOfBirth) && params.key?(:lastName)
        flash.now[:alert] = case params[:dateOfBirth].blank? || params[:lastName].blank?
                              when params[:dateOfBirth].blank?
                                'Please fill in the date of birth'
                              when params[:lastName].blank?
                                'Please fill in the last name'
                              else
                                'Please fill in the all fields'
                            end
      end
    end

  end

  def create
    authorize(:admission)
    @admission = Admission.new(admission_params)

    respond_to do |format|
      # It is important to check it save it
      if @admission.save

        # if @admission.admissionDate.to_date == Date.today
        # Admitted, Discharged, Scheduled
        @admission.scheduled!

        format.html { redirect_to(admissions_path, notice: 'Admission schedule successful. Reminder text will be sent to patient, before due.') }
      else
        # puts(@admission.inspect)
        # Pass the errors, to the instance variable
        format.html { render :new }
        format.js { render(:error_appender, locals: { model_with_errors: @admission, id_of_error_holder_div: 'error_holder_admissions' }) }
      end
    end
  end

  # @return [admission]
  def edit;
    # Make sure admission cannot be edited indirectly
    # Only: under admitted and scheduled
    if !@admission.discharged? && (@admission.admitted? || @admission.scheduled?)
      render(:edit)
    else
      flash[:alert] = 'This admission cannot be edited.'
      redirect_to(request.referrer || root_path)
    end
  end

  def update
    respond_to do |format|
      # TODO other things need consideration such as team, when moved, track history, so disable updating ward instead
      #
      # Detect changed ward, after update ward may change
      # ward_id_for_later = @admission.ward_id

      # Do further validation by selecting only the admission note and current medication to update
      if @admission.update(currentMedications: params[:admission][:currentMedications],
                           admissionNote: params[:admission][:admissionNote])
        # Disabled
        #
        # if @admission.ward_id_changed?
        #   # Update the old ward
        #   Ward.find(ward_id_for_later).update_bed_status_add
        #
        #   # Update the new ward
        #   @admission.update_bed_status_minus
        # end
        format.html { redirect_to(@admission, notice: 'Admission update successful.') }
      else
        format.html { render(:edit) }
        format.js { render(:edit, status: :unprocessable_entity) }
      end
    end
  end

  # Discharges patient now/today
  def destroy
    # Admitted / Discharged
    @admission.dischargeDate = Time.now
    @admission.discharged!

    if @admission.save!
      # Update Ward Status, Increment
      @admission.update_bed_status_add

      redirect_to(admissions_path, notice: 'Patient discharged')
    end
  end

  def admit_scheduled
    # TODO, actual time admitted
    # Admitted, Discharged, Scheduled
    if @admission.admitted!
      redirect_to(@admission, notice: 'Patient admitted')

      # Update Ward Status, Decrement
      @admission.update_bed_status_minus
    end
  end

  def cancel_scheduled
    # Delete the record
    if @admission.destroy
      redirect_to(@admission, notice: 'Admission cancelled')
    end
  end

  # Finds patient to discharge
  def find_and_discharge
    authorize(:admission)
    if params.include?(:ward_id) && params.include?(:patient_id) && @patient.eql?(nil)
      @admission = Admission.where(patient_id: params[:patient_id], ward_id: params[:ward_id], status: 'Discharged').first
      if @admission
        # Redirect to display discharge modal
        redirect_to(discharge_admission_path(@admission.id))
      else
        flash.now[:alert] = 'No patient found'
      end
    elsif params.include?(:rest_patient)
      @patient = nil
    else
      # Extra validation in case otherwise normal should not get past html required attribute
      if params.key?(:ward_id) && params.key?(:patient_id)
        flash.now[:alert] = case params[:ward_id].blank? || params[:patient_id].blank?
                              when params[:ward_id].blank?
                                'Please select Ward'
                              when params[:patient_id].blank?
                                'Please select patient'
                              else
                                'Please select available fields'
                            end
      end
    end
  end

  # Displays discharge modal/dialog
  #
  # GET method
  def discharge
    respond_modal_with(@admission)
  end

  # Authorises discharge, to set date once and only once cannot be changed directly
  #
  # POST Method
  def authorise_discharge
    if !params[:admission][:dischargeDate].blank?
      if @admission.update(dischargeDate: params[:admission][:dischargeDate])

        # Schedule the discharge
        Admission.delay(run_at: @admission.dischargeDate).set_status_discharge(@admission.id)

        redirect_to(admissions_path, notice: 'Successful discharge authorisation')
      else
        # In case of error, they will handled by the authorise discharge js error appender
        respond_with(@admission)
      end
    else
      # Call authorise discharge js error appender
      respond_with(@admission)
    end
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