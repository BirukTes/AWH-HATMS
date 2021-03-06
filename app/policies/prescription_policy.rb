# Defines policy for prescriptions controller actions
#
# @author Bereketab Gulai
class PrescriptionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    staff.consultant? || staff.doctor? || staff.staff_nurse? || staff.nurse?
  end

  def update?
    staff.consultant? || staff.doctor? || staff.staff_nurse? || staff.nurse?
  end

  def destroy?
    staff.consultant? || staff.doctor? || staff.staff_nurse? || staff.nurse?
  end
end
