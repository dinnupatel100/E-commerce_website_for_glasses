# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    
    can :login, User

    if user.admin?
      can :manage, Category
      can [:read,:destroy], User
      can :manage, ProductDetail
      can :manage, ProductColor
      can :manage, Product
      can [:read, :show_all_orders], Order
    else 
      can [:read,:show_category_products], Category
      can [:create,:update], User
      can :manage, Order
      cannot [:index, :show_all_orders], Order
      can [:read,:search_result], ProductDetail
      can :read, ProductColor
      can :read, Product
      can :manage, Review
    end
    
  end
end
