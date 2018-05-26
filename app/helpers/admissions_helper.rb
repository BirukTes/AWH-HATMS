module AdmissionsHelper

  def display_discharge?(admission)
    (admission.dischargeDate.nil? && admission.admitted? && !admission.scheduled?) && policy(:admission).discharge?
  end
end
