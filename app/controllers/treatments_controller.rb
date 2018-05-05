class TreatmentsController < ApplicationController
  before_action(:set_treatment, only: [:show, :edit, :update, :destroy])

  # Declaration of respond-able formats
  respond_to(:html, :json)

  # Authorisation callbacks
  after_action(:verify_authorized, except: :index)
  after_action(:verify_policy_scoped, only: :index)

  def index
    @treatments = policy_scope(Treatment)
  end

  def show
  end

  def new
    @treatment = Treatment.new
    authorize @treatment

    if params.include?(:ward_id) && params.include?(:patient_id) && @patient.eql?(nil)
      @patient = Patient.find(params[:patient_id])

    elsif params.include?(:rest_patient)
      @patient = nil
    end
  end

  def create
    @treatment = Treatment.new(treatment_params)
    authorize @treatment

    if @treatment.save
      redirect_to(treatments_path, notice: 'Treatment saved')
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
    if @treatment.update(treatment_params)
      redirect_to(treatments_path, notice: 'Update successful')
    else
      respond_with(:edit)
    end
  end

  def destroy
    @treatment.destroy
    respond_to(:index, notice: 'Treatment Deleted')
  end

  private

  def treatment_params
    params.require(:treatment).permit(:id, :note, :date, :issuedBy, :ward_id, :patient_id, :rest_patient)
  end

  def set_treatment
    @treatment = Treatment.find(params[:id])
    authorize @treatment
  end

end
