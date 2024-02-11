# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)

    if user.role == "admin"
      can :manage , Category
    else 
      can :read , Category
    end
  end
end
