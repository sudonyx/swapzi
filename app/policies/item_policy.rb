class ItemPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.where(hidden: false).order(created_at: :desc)
    end
  end

  def index?
    true
  end

  def new?
    create?
  end

  def create?
    true
  end

  def show?
    true
  end

  def destroy?
    true
  end

  def dashboard?
    true
  end

  def edit?
    true
  end

  def update?
    true
  end

  def relist?
    true
  end
end
