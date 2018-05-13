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

  def find_patients_discharge_unauthorised
    if params[:ward_id_selected]
      patients_option = Admission.find_discharge_unauthorised_admitted_patients(params[:ward_id_selected])

      respond_with(patients_option)
    end
  end


  private

  def find_params
    params.require(:find).permit(:ward_id_selected)
  end

end