class TreatmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    staff.consultant? || staff.doctor? || staff.staff_nurse? || staff.nurse?
  end

  # Override definition in the application policy
  def create?
    staff.consultant? || staff.doctor?
  end

  def update?
    staff.consultant? || staff.doctor?
  end

  def destroy?
    staff.consultant? || staff.doctor?
  end
end
