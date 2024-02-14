class ProductDetailsController < ApplicationController
  before_action :set_product_detail, only: [:show, :destroy]

  def index
    @product_details = ProductDetail.all
    if @product_details.empty?
      render json: "No products found", status: :not_found
    else
      render json: @product_details, status: :ok
    end
  end

  def create
    product_details = ProductDetail.new(product_detail_params)
    if product_details.save
      render json: product_details, status: :created
    else
      render json: product_details.errors.full_messages, status: :bad_request
    end
  end

  def show
    if @product_detail.nil?
      render json: "Products doesn't exist", status: :not_found
    else
      @product_colors = @product_detail.product_colors.pluck(:color)
      if @product_colors.empty?
        render json: "Product colors doesn't exist", status: :not_found
      else
        @product_size = @product_detail.product_colors.first.products.pluck(:size)
        render json: {
          product_detail: @product_detail,
          product_colors: @product_colors,
          product_size: @product_size
        }, status: :ok
      end
    end
  end

  def destroy
    if @product_detail.nil?
      render json: "product doesn't exist", status: :not_found
    else
      @product_detail.destroy
      render json: "Product details deleted successfully", status: :ok
    end
  end

  def search_result
    @category = Category.where("category_name LIKE ?", "%#{params[:keywords]}%")
    if (@category.empty?)
      @products = ProductDetail.where("product_name LIKE ? OR brand LIKE ?", "%#{params[:keywords]}%", "%#{params[:keywords]}%")
    else
      @products = ProductDetail.where("product_name LIKE ? OR brand LIKE ? OR category_id = ?",
                               "%#{params[:keywords]}%", "%#{params[:keywords]}%", "#{@category.first.id}")
    end 

    if @products.empty?
      render json: "Product doesn't exist", status: :not_found
    else
      render json: @products, status: :ok
    end
  end

  private 

  def product_detail_params
    
    params.require(:product_detail).permit(:product_name, :product_description, :cost_price, :selling_price, :brand, :category_id)
  end

  def set_product_detail
    @product_detail = ProductDetail.find_by(id: params[:id])
  end

end
