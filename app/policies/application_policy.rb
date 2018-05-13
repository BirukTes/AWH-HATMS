class ApplicationPolicy
  # Pundit also allows to authorize on a record by record, in this project this
  # will not be the case only who has access to the action or function, by user role.

  # All methods return either true on the given condition
  # In this case, project
  # True - Indicates a specific logged in staff has access to the action or function
  # False - Indicates a specific logged in staff has no access to the action or function
  #
  # If a method returns the value 'true' by itself without condition - all staff can access it,
  # Inversely as 'false' - No staff
  #
  # All methods or some are overridden by subclasses (policies) according to their needs

  # @return staff, record
  attr_reader :staff, :record

  def initialize(staff, record)
    @staff = staff
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(staff, record.class)
  end

  class Scope
    attr_reader :staff, :scope

    def initialize(staff, scope)
      # Defines a filter that redirects unauthenticated users to the login page.
      # Raised only, the action has gotten past the primary authentication layer, Devise
      raise Pundit::NotAuthorizedError, "must be logged in" unless staff
      @staff = staff
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
