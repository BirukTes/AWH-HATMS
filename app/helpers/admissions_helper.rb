module AdmissionsHelper

  def display_discharge?(admission)
    (admission.dischargeDate.nil? || admission.admitted?) && policy(:admission).discharge?
  end

  # fixme
  def colspan_num(admission)
    if !admission.scheduled? && !display_discharge?(admission)
      3
    elsif admission.scheduled? && display_discharge?(admission)
      0
    elsif !display_discharge?(admission) && (admission.scheduled? && policy(:admission).new?)
      1
    elsif display_discharge?(admission) && !admission.scheduled?
      2
    else
      2
    end
  end
end
