class DiagnosesController < ApplicationController
  before_action :set_diagnosis, only: [:show, :edit, :update, :destroy]


  # GET /diagnoses
  # GET /diagnoses.json
  def index
    authorize(:diagnoses)
    @diagnoses = Diagnosis.all
  end

  # GET /diagnoses/1
  # GET /diagnoses/1.json
  def show
  end

  # GET /diagnoses/new
  def new
    # binding.pry
    authorize(:diagnoses)
    @diagnosis = Diagnosis.new

    if params.include?(:ward_id) && params.include?(:patient_id) && @patient.eql?(nil)
      admission_id_extract = params[:patient_id].split('|')[1]
      @admission = Admission.find(admission_id_extract)

      # Save the admission to session and use it if re-rendering is required (create errors)
      session[:current_diagnosing_admission] = @admission
    elsif params.include?(:rest_patient)
      @admission = nil
    end
  end

  # GET /diagnoses/1/edit
  def edit
  end

  # POST /diagnoses
  # POST /diagnoses.json
  def create
    authorize(:diagnoses)
    @diagnosis = Diagnosis.new(diagnosis_params)

    respond_to do |format|
      if @diagnosis.save
        format.html { redirect_to @diagnosis, notice: 'Diagnosis was successfully created.' }
        format.json { render :show, status: :created, location: @diagnosis }
      else
        format.html { render :new }
        format.js
      end
    end
  end

  # PATCH/PUT /diagnoses/1
  # PATCH/PUT /diagnoses/1.json
  def update
    respond_to do |format|
      if @diagnosis.update(diagnosis_params)
        format.html { redirect_to @diagnosis, notice: 'Diagnosis was successfully updated.' }
        format.json { render :show, status: :ok, location: @diagnosis }
      else
        format.html { render :edit }
        # Use the same js view, only need to print errors
        format.js { render :create }
      end
    end
  end

  # DELETE /diagnoses/1
  # DELETE /diagnoses/1.json
  def destroy
    @diagnosis.destroy
    respond_to do |format|
      format.html { redirect_to diagnoses_url, notice: 'Diagnosis was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_diagnosis
    authorize(:diagnoses)
    @diagnosis = Diagnosis.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def diagnosis_params
    params.require(:diagnosis).permit(:title, :description, :admission_id, :ward_id, :patient_id)
  end
end
