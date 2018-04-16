class AdmissionsController < ApplicationController

  # This defines the responses types, or It is referencing the response that will
  # be sent to the View (which is going to the browser) https://stackoverflow.com/a/9492463/5124710
  respond_to :html

  def index
    @admissions = Admission.all

  end

  def show
    @admission = Admission.find(params[:id])
  end

  def new
    @admission = Admission.new

    # TODO check for blank
    if params.include?(:dateOfBirth) && params.include?(:lastName) && @patient.eql?(nil)
      @patient = Patient.find_patient(params[:dateOfBirth], params[:lastName])
      # puts(@patient.inspect)
    elsif params.include?(:rest_patient)
      @patient = nil
    end
  end

  def create
    @admission = Admission.new(admission_params)

    if @admission.save!
      redirect_to(admissions_path(@admission), notice: 'Admission successful')
    else
      # puts(@admission.inspect)
      # Pass the errors, to the instance variable, TODO errors
      @errors = @admission.errors.full_messages
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

  def admission_params
    params.require(:admission).permit(:admissionDate, :dischargeDate, :currentMedications, :admissionNote,
                                      :ward_id, :patient_id, :dateOfBirth, :lastName, :team_category)
  end
end
