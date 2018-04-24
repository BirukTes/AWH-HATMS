class TreatmentsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @treatment = Admission.new

    # TODO check for blank
    if params.include?(:dateOfBirth) && params.include?(:lastName) && @patient.eql?(nil)
      @patient = Patient.find_patient(params[:dateOfBirth], params[:lastName])
    elsif params.include?(:rest_patient)
      @patient = nil
    end
  end

  def create
    @treatment = Treatment.new(treatment_params)

    if @treatment.save!
      redirect_to(treatments_path(@treatment), notice: 'Treatment saved')
    else
      # puts(@admission.inspect)
      # Pass the errors, to the instance variable, TODO errors
      @errors = @treatment.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def treatment_params
    params.require(:admission).permit(:admissionDate, :dischargeDate, :currentMedications, :admissionNote,
                                      :ward_id, :patient_id, :dateOfBirth, :lastName, :team_category)
  end
end
