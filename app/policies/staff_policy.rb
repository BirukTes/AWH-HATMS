class StaffPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end


  def index?
    staff.medical_staff_admin? || staff.consultant?
  end

  def show?
    staff.medical_staff_admin? || staff_profile
  end

  def create?
    staff.medical_staff_admin?
  end

  def update?
    staff.medical_staff_admin? || staff_profile
  end

  def destroy?
    staff.medical_staff_admin?
  end

  private

  # Checks the record (staff) to be viewed is their o
  # @return [true/false] if the record is of their own
  def staff_profile
    staff.id == record.id
  end
end
