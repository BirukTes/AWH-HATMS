# Defines policy for teams controller actions
#
# @author Bereketab Gulai
class TeamPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end


  def index?
    true
  end

  # Extend
  def show?
    true
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
