class ApplicationPolicy
  attr_reader :staff, :record

  def initialize(staff, record)
    @staff = staff
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
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
      raise Pundit::NotAuthorizedError, "must be logged in" unless staff
      @staff = staff
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
