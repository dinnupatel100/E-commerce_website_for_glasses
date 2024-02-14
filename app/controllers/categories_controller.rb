class CategoriesController < ApplicationController
  before_action :set_category, only: [:destroy, :update, :show_category_products]
  
  def index
    @categories =  Category.all
    if @categories.empty?
      render json: "No category found", status: :not_found
    else
      render json: @categories, status: :ok
    end
  end

  def add_category
    category = Category.new(category_params)
    if category.save
      render json: category, status: :created
    else
      render json: category.errors.full_messages, status: :bad_request
    end
  end

  def show_category_products
    byebug
    if @category.nil?
      render json: "Category doesn't exist" , status: :not_found
    else
      @category_products =  @category.product_details
      render json: @category_products , status: :ok
    end
  end

  def destroy 
    if @category.nil?
      render json: "Failed to delete", status: :bad_request
    else
      @category.destroy
      render json: "Deleted Successfully" , status: :ok
    end
  end

  def update
    if @category.nil?
      render json: "failed to update category, category doesn't exist", status: :bad_request
    else
      @category.update(category_params)
      render json: "Category Updated Successfully", status: :ok
    end
  end

  private

  def category_params
    params.require(:category).permit(:category_name)
  end

  def set_category
    @category = Category.find_by(id: params[:id])
  end

end
