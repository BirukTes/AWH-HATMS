class ApplicationPolicy
  attr_reader :staff, :record

  def initialize(user, record)
    @staff = user
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
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :staff, :scope

    def initialize(user, scope)
      @staff = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
