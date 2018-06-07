class AdmissionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    # All staff
    true
  end

  # Override definition in the application policy
  def create?
    staff.medical_staff_admin?
  end

  def show?
    true
  end

  def update?
    staff.medical_staff_admin?
  end

  def destroy?
    staff.doctor? || staff.consultant?
  end

  def discharge?
    (staff.doctor? || staff.consultant?) #&& member_of_ward?
  end

  def admit_scheduled?
    staff.medical_staff_admin?
  end

  def cancel_scheduled?
    staff.medical_staff_admin?
  end


  def find_and_discharge?
    staff.doctor? || staff.consultant?
  end

  def authorise_discharge?
    staff.doctor? || staff.consultant?
  end

# private

# TODO team should be of ward
# def member_of_ward?
# if staff.team == record.allocations
# end
end