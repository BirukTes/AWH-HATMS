class DiagnosesPolicy < ApplicationPolicy
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
    # FIXME staff needs to be the one that created the record, add issueBy to table
    staff.consultant? || staff.doctor? || staff.staff_nurse? || staff.nurse?
  end

  def destroy?
    staff.medical_staff_admin?
  end
end
