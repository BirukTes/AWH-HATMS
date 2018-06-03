# Prescriptions Controller, manages all drup prescriptions requests, index, creation, deletion and more
class PrescriptionsController < ApplicationController
  before_action(:set_prescription, only: [:show, :edit, :update, :destroy])


  def index
    # Needs to know the policy, which is of prescription
    authorize(:prescription)
    @prescriptions = Prescription.all
  end

  def show
  end

  def new
    authorize(:prescription)
    @prescription = Prescription.new
    @prescription.medications.build

    if params.include?(:ward_id) && params.include?(:patient_id) && @patient.eql?(nil)
      admission_id_extract = params[:patient_id].split('|')[1]
      @diagnosis = Diagnosis.find_by(admission_id: admission_id_extract)

      # Save the admission to session and use it if re-rendering is required (create errors)
      session[:current_prescribing_diagnosis] = @diagnosis
    elsif params.include?(:rest_patient)
      @diagnosis = nil
    end
  end

  def create
    authorize(:prescription)
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
    params.require(:prescription).permit(:id, :date, :dosage, :treatmentLength, :issuedBy, :diagnosis_id,
                                         :ward_id, :patient_id, medications_attributes: [:id, :drug_id, :_destroy])
  end


  # @return [admission]
  def set_prescription
    authorize(:prescription)
    @prescription = Prescription.find(params[:id])
  end
end
