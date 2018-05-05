class TeamPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end


  def index?
    staff.medical_staff_admin? || staff.consultant?
  end

  def show
    staff.medical_staff_admin? || staff.consultant?
  end

  def create?
    staff.medical_staff_admin?
  end

  def update?
    staff.medical_staff_admin?
  end

  def destroy?
    staff.medical_staff_admin?
  end
end
