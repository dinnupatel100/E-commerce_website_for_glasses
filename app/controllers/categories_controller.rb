class CategoriesController < ApplicationController
  load_and_authorize_resource
  before_action :set_category, only: [:destroy, :update, :show_category_products]
  
  def index
    @categories =  Category.all
    if @categories.empty?
      render json: {
        message: I18n.t("category.categoryEmpty"),
        category: @categories
        }, status: :ok
    else
      render json: @categories, status: :ok
    end
  end

  def add_category
    category = Category.new(category_params)
    if category.save
      render json: {
        message: I18n.t("category.categoryAddSuccess")
      }, status: :ok
    else
      render json: {error: category.errors.full_messages}, status: :bad_request
    end
  end

  def show_category_products
    if @category.nil?
      render json: { message: I18n.t("category.categoryNotExist")} , status: :bad_request
    else
      @category_products =  @category.product_details
      if @category_products.empty?
        render json: { 
          message: I18n.t("category.showProductsError"),
        products: @category_products
        }, status: :not_found
      else
        render json: @category_products , status: :ok
      end
    end
  end

  def destroy 
    if @category.nil?
      render json: {message: I18n.t("category.categoryNotExist")}, status: :bad_request
    else
      @category.destroy
      render json: {message: I18n.t("category.deleteCategory")}, status: :ok
    end
  end

  def update
    if @category.nil?
      render json: {message: I18n.t("category.categoryNotExist") }, status: :bad_request
    else
      @category.update(category_params)
      render json: {message: I18n.t("category.categoryUpdateSuccess")}, status: :ok
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
