class Search::FindController < ApplicationController
  # Json only for now
  respond_to :json


  def find_discharged_without_invoice_patients_in_ward
    if params[:ward_id_selected]
      patients_option = Admission.find_discharged_without_invoice_patients(params[:ward_id_selected])

      respond_with(patients_option)
    end
  end

  def find_admitted_patients_in_ward
    if params[:ward_id_selected]
      patients = Admission.find_admitted_patients(params[:ward_id_selected])

      respond_with(patients)
    end
  end

  def find_admitted_diagnosed_patients_in_ward
    if params[:ward_id_selected] && params[:patient_id_selected]
      admission = Admission.find_admitted_diagnosed_patients(params[:ward_id_selected], params[:patient_id_selected])

      diagnoses_option = admission.diagnoses.map do |diagnosis|
        [diagnosis.title, diagnosis.id]
      end

      respond_with(diagnoses_option)
    end
  end

  def find_patients_discharge_unauthorised
    if params[:ward_id_selected]
      patients_option = Admission.find_discharge_unauthorised_admitted_patients(params[:ward_id_selected])

      respond_with(patients_option)
    end
  end


  private

  def find_params
    params.require(:find).permit(:ward_id_selected, :patient_id_selected)
  end

  # Class method, used by +find_discharged_without_invoice_patients+
  #
  # Gets array of name and id of passed in patient
  #
  # @return [Admission# name : string, id:string]
  def patients_option(patient, admission)
    #  Add admission number beginning of the array, NOTICE the end with '|' as delimiter, requires extraction
    ['Admission #' + admission.id.to_s + ' ' + patient.person.firstName + ' ' + patient.person.lastName,
     patient.id.to_s + '|' + admission.id.to_s]
  end

end