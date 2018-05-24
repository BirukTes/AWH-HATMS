class AdmissionsController < ApplicationController
  # Sets the admission object for the following actions
  before_action(:set_admission, only: [:show, :edit, :update, :destroy, :discharge, :authorise_discharge,
                                       :admit_scheduled, :cancel_scheduled])

  # Authorisation callbacks
  # Make sure all actions perform authorisation, (individual records),
  # index retrieves multiple records so exclude
  after_action(:verify_authorized)

  # Verify authorisation for all admissions (multiple records), which index only does
  # after_action(:verify_policy_scoped, only: :index)

  def index
    authorize(:admission)
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
      # Extra validation in case otherwise normal should not get past html required attribute
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

    respond_to do |format|
      # It is important to check it save it
      if @admission.save

        # Admitted, Discharged, Scheduled
        @admission.scheduled!

        # Update the bed status with new value if it nil or 0, otherwise continue to decrement it current value
        # At this point it is reserved
        @admission.ward.update(bedStatus: if @admission.ward.bedStatus.nil? || @admission.ward.bedStatus == 0
                                            @admission.ward.numberOfBeds - 1
                                          else
                                            @admission.ward.bedStatus - 1
                                          end)


        format.html { redirect_to(admissions_path, notice: 'Admission successful') }
      else
        # puts(@admission.inspect)
        # Pass the errors, to the instance variable
        format.html { render :new }
        format.js { render :new, status: :unprocessable_entity }
      end
    end
  end

  # @return [admission]
  def edit;
  end

  def update
    respond_to do |format|
      # Detect changed ward
      ward_id_for_later = @admission.ward_id

      if @admission.update(admission_params)
        if @admission.ward_id_changed?
          # Update the old ward
          Ward.find(ward_id_for_later).update(bedStatus: if @admission.ward.bedStatus >= @admission.ward.numberOfBeds
                                                           # Don't add anything, already max?
                                                           0
                                                         else
                                                           @admission.ward.bedStatus + 1
                                                         end)

          # Update the new ward
          @admission.ward.update(bedStatus: if @admission.ward.bedStatus.nil? || @admission.ward.bedStatus == 0
                                              @admission.ward.numberOfBeds - 1
                                            else
                                              @admission.ward.bedStatus - 1
                                            end)
        end
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
    @admission.status = 'Discharged'

    if @admission.save!
      # Return the one bed, and update the ward bedStatus
      # Check for max, in case goes above actual number, refactor once stable
      @admission.ward.update(bedStatus: if @admission.ward.bedStatus >= @admission.ward.numberOfBeds
                                          # Don't add anything, already max?
                                          0
                                        else
                                          @admission.ward.bedStatus + 1
                                        end)
      redirect_to(admissions_path, notice: 'Patient discharged')
    end
  end

  def admit_scheduled
    # TODO, actual time admitted
    # Admitted, Discharged, Scheduled
    if @admission.admitted!
      redirect_to(@admission, notice: 'Patient admitted')
    end
  end

  def cancel_scheduled
    # Update first of all
    # Check for max, in case goes above actual number
    @admission.ward.update(bedStatus: if @admission.ward.bedStatus >= @admission.ward.numberOfBeds
                                        # Don't add anything, already max?
                                        0
                                      else
                                        @admission.ward.bedStatus + 1
                                      end)


    # Then delete
    if @admission.destroy
      redirect_to(@admission, notice: 'Admission cancelled.')
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