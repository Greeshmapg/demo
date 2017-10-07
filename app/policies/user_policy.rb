class UserPolicy < ApplicationPolicy
  def view_edit_profile?
    if user == record
      return true
    else
      return false
    end
  end

  def show?
    if user.id == record[:id]
      return true
    else
      return false
    end
  end

  def create?
    user.admin?
  end

  def destroy?
      user.admin?
  end

  private



end
