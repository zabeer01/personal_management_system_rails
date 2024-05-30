class UserPolicy < ApplicationPolicy
  def index?
    user.present?  # Only authenticated users can view the list of users
  end

  def show?
    true  # Anyone can view a user
  end

  def create?
    user.admin?  # Only admin users can create users
  end

  def update?
    user.admin?  # Only admin users can update users
  end

  def destroy?
    user.admin?  # Only admin users can delete users
  end

  def edit?
    user.admin?  # Only admin users can edit users
  end

  def new?
    user.admin?  # Only admin users can create a new user
  end

  class Scope < Scope
    def resolve
      scope.all  # All users can see all items
    end
  end
end
