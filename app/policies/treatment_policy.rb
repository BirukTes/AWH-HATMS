class TreatmentPolicy < ApplicationPolicy
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

  # Override definition in the application policy
  def create?
    staff.consultant? || staff.doctor? || staff.staff_nurse? || staff.nurse?
  end

  def update?
    # FIXME staff needs to be the one that created the record, use issueBy
  staff.consultant? || staff.doctor? || staff.staff_nurse? || staff.nurse?
  end

  def destroy?
    staff.medical_staff_admin? || staff.consultant? || staff.doctor?
  end
end

