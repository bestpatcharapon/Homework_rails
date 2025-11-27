# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    
    if user.admin?
      can :manage, :all
    elsif user.staff?
      can :read, :all
    else
      can :read, Recipe
      can :read, Category
    end
  end
end
