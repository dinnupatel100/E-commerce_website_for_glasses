# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    
    can :login, User

    if user.admin?
      can :manage, Category
      can :destroy, User
      can :read, User
      can :read, Order
      can :manage, ProductDetail
      can :manage, ProductColor
      can :manage, Product
    else 
      can :read, Category
      can :show_category_products, Category
      can :create, User
      can :update, User
      can :manage, Order
      cannot :index, Order
      can :search_result, ProductDetail
      can :read, ProductDetail
      can :read, ProductColor
      can :read, Product
    end
    
  end
end
