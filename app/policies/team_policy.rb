class TeamPolicy < ApplicationPolicy


  def update?
    user.admin?
  end

  def create?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  def add_to_team?
    if user.admin? || user.teams.find_by(id: record.id).present?
      return true
    else
      return false
    end
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      else
        user.teams
      end
    end
  end


end
