class PatientPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    true
  end

  def show
    true
  end

  def create?
    staff.medical_staff_admin? || staff.consultant?
  end

  def update?
    staff.medical_staff_admin? || staff.consultant?
  end

  def destroy?
    staff.medical_staff_admin?
  end
end
