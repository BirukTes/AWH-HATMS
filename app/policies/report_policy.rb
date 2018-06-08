# Defines custom headless policy for reports controller actions
#
# @author Bereketab Gulai
class ReportPolicy < Struct.new(:staff, :report)
  def medications_list?
    true
  end

  def discharge_list?
    true
  end

  def patient_card?
    true
  end

  def ward_list?
    true
  end
end
