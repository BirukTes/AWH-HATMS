class InvoicePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  # All actions are only available to admin
  def index?
    staff.medical_staff_admin?
  end

  def show?
    staff.medical_staff_admin?
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
