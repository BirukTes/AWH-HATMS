module AdmissionsHelper

  def display_discharge?(admission)
    (admission.dischargeDate.nil? && admission.admitted? && !admission.scheduled?) && policy(:admission).discharge?
  end

  # Gets the Bootstrap badge class for given admission status
  #
  # @return [String] badge class
  def admission_badge_class_helper(admission_status)
    case admission_status.to_sym
      when :admitted
        'badge-success'
      when :scheduled
        'badge-warning'
      when :discharged
        'badge-danger'
    end
  end
end
