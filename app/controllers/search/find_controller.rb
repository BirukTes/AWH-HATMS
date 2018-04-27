class Search::FindController < ApplicationController
  respond_to :json, :js, :html

  def find_patients_in_ward
    patients = Admission.find_admitted_patients(params[:ward_id_selected])

    patient_options = patients.map do |patient|
      [patient.person.firstName + ' ' + patient.person.lastName, patient.id]
    end

    patient_options.inspect

    respond_to do |format|
      format.json { render json: patient_options }
    end
  end

  private

  def find_params
    params.require(:find).permit(:ward_id_selected)
  end
end