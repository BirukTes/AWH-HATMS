class AdmissionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # FIXME nill
      if staff.medical_staff_admin?
        scope.all
      else
        scope.where(status: 'Admitted')
      end
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

  def update?
    staff.medical_staff_admin?
  end

  def destroy?
    staff.medical_staff_admin?
  end

  def discharge?
    staff.doctor? || staff.consultant?
  end

  def find_and_discharge?
    staff.doctor? || staff.consultant?
  end

  def authorise_discharge?
    staff.doctor? || staff.consultant?
  end
end