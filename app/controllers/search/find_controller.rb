class Search::FindController < ApplicationController
  respond_to :json, :js, :html

  def find_patients_in_ward
    patients = Admission.find_admitted_patients(params[:ward_id_selected])

    respond_with(patient_options(patients))
  end

  def find_patients_discharge_unauthorised
    patients = Admission.find_discharge_unauthorised_admitted_patients(params[:ward_id_selected])

    respond_with(patient_options(patients))
  end


  private

  def find_params
    params.require(:find).permit(:ward_id_selected)
  end

  def patient_options(patients)
    patients.map do |patient|
      [patient.person.firstName + ' ' + patient.person.lastName, patient.id]
    end
  end
end