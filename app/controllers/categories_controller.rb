class CategoriesController < ApplicationController
  before_action :set_category, only: [:destroy, :update, :show_category_products]
  load_and_authorize_resource

  def index
    @categories =  Category.all
    render json: @categories
  end

  def add_category
    category = Category.new(category_params)
    if category.save
      render json: category, status: :created
    else
      render json: category.errors.full_messages
    end
  end

  def show_category_products
    if @category == nil
      render json: "No category found"
    else
      @category_products =  @category.product_details
      render json: @category_products 
    end
  end

  def destroy 
    @category.destroy
    if @category.destroyed?
      render json: "Deleted Successfully"
    else
      render json: "Failed to delete"
    end
  end

  def update
    if @category.update(category_params)
      render json: "Category Updated Successfully"
    else
      render json: "Failed to update category"
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
