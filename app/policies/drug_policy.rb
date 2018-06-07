class DrugPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    staff.medical_staff_admin? || staff.ward_sister?
  end

  def show?
    staff.medical_staff_admin? || staff.ward_sister?
  end

  def create?
    staff.medical_staff_admin? || staff.ward_sister?
  end

  def update?
    staff.medical_staff_admin? || staff.ward_sister?
  end

  def destroy?
    staff.medical_staff_admin?
  end
end
