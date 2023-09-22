class FavouritePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def destroy?
    true
  end

  def create?
    true
  end

  def show?
    true
  end

  def index?
    true
  end

  def dashboard?
    true
  end
end
