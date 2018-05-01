class PrescriptionsController < ApplicationController
  before_action(:set_prescription, only: [:show, :edit, :update])

  def index
    @prescriptions = Prescription.all
  end

  def show
  end

  def new
    @prescription = Prescription.new
    @prescription.medications.build

    if params.include?(:ward_id) && params.include?(:patient_id) && @patient.eql?(nil)
      @patient = Patient.find(params[:patient_id])

    elsif params.include?(:rest_patient)
      @patient = nil
    end
  end

  def create
    @prescription = Prescription.new(prescription_params)

    if @prescription.save
      redirect_to(prescriptions_path, notice: 'Prescription created successfully')
    end
  end

  def edit
  end

  def update
    if @prescription.update(prescription_params)
      redirect_to(prescriptions_path, notice: 'Update successful')
    else
      respond_with(:edit)
    end
  end

  def destroy
    @prescription.destroy
    respond_to(:index, notice: 'Treatment Deleted')
  end

  # Private methods
  private

  # @return [params]
  def prescription_params
    params.require(:prescription).permit(:id, :date, :dosage, :treatmentLength, :issuedBy,
                                         :ward_id, :patient_id, medications_attributes: [:drug_id])
  end


  # @return [admission]
  def set_prescription
    @prescription = Prescription.find(params[:id])
  end
end
