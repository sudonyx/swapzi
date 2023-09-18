class UserProfilePolicy < ApplicationPolicy
  def show?
    user == record
  end

  def edit?
    user == record
  end

  def update?
    user == record
  end
end
