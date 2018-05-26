class TreatmentsController < ApplicationController
  before_action(:set_treatment, only: [:show, :edit, :update, :destroy])

  # Declaration of respond-able formats
  respond_to(:html, :json)

  # Authorisation callbacks
  after_action(:verify_authorized)

  def index
    authorize(:treatment)
    @treatments = Treatment.all
  end

  def show
  end

  def new
    authorize(:treatment)
    @treatment = Treatment.new

    if params.include?(:ward_id) && params.include?(:patient_id) && @patient.eql?(nil)
      admission_id_extract = params[:patient_id].split('|')[1]
      @admission = Admission.find(admission_id_extract)

    elsif params.include?(:rest_patient)
      @patient = nil
    end
  end

  def create
    authorize(:treatment)
    @treatment = Treatment.new(treatment_params)

    if @treatment.save
      redirect_to(treatments_path, notice: 'Note saved')
    else
      respond_with(@treatment)
    end
  end

  def edit
  end

  def update
    if @treatment.update(treatment_params)
      redirect_to(treatments_path, notice: 'Note update successful')
    else
      respond_with(:create)
    end
  end

  def destroy
    @treatment.destroy
    redirect_to(:index, notice: 'Note deleted successfully')
  end

  private

  def treatment_params
    params.require(:treatment).permit(:id, :note, :date, :issuedBy, :ward_id, :admission_id, :rest_patient)
  end

  def set_treatment
    authorize(:treatment)
    @treatment = Treatment.find(params[:id])
  end

end
