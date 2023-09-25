class ConversationPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.where(user_1: user).or(scope.where(user_2: user))
    end
  end

  def index?
    true
  end
  
  def show?
    true
  end

  def create?
    true
  end
end
