class DiagnosesPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
  def index?
    staff.consultant? || staff.doctor? || staff.staff_nurse? || staff.nurse?
  end

  def show?
    staff.consultant? || staff.doctor? || staff.staff_nurse? || staff.nurse?
  end

  def create?
    staff.consultant? || staff.doctor? || staff.staff_nurse? || staff.nurse?
  end

  def update?
    staff.consultant? || staff.doctor? || staff.staff_nurse? || staff.nurse?
  end

  def destroy?
    staff.medical_staff_admin?
  end
end
