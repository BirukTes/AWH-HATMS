# Handles treatement/notes system, to view, create and update
#
# @author Bereketab Gulai
class TreatmentsController < ApplicationController
  before_action(:set_treatment, only: [:show, :edit, :update, :destroy])

  # GETs all notes
  def index
    authorize(:treatment)
    @treatments = Treatment.all
  end

  # GETs individual note
  def show
  end

  # GETs create note form
  def new
    authorize(:treatment)
    @treatment = Treatment.new

    if params.include?(:ward_id) && params.include?(:patient_id) && @admission.eql?(nil)
      admission_id_extract = params[:patient_id].split('|')[1]
      @admission = Admission.find(admission_id_extract)

    elsif params.include?(:rest_patient)
      @admission = nil
    end
  end

  # POSTs note creation
  def create
    authorize(:treatment)
    @treatment = Treatment.new(treatment_params)

    if @treatment.save
      redirect_to(treatments_path, notice: 'Note was successfully created')
    else
      respond_with(@treatment)
    end
  end

  # GETs edit form
  def edit
  end

  # POST method, receives edit form to create note
  def update
    if @treatment.update(treatment_params)
      redirect_to(treatments_path, notice: 'Note was successfully updated')
    else
      respond_with(:create)
    end
  end

  # DELETE method to destroy
  def destroy
    @treatment.destroy
    redirect_to(treatments_path, notice: 'Note was successfully deleted')
  end

  private

  # Permitted params
  def treatment_params
    params.require(:treatment).permit(:id, :note, :date, :issuedBy, :ward_id, :admission_id, :rest_patient)
  end

  # Authorises and sets note
  def set_treatment
    authorize(:treatment)
    @treatment = Treatment.find(params[:id])
  end

end
