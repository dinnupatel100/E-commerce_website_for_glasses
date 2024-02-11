class ProductDetailsController < ApplicationController
 
  before_action :set_product_detail, only: [:image_of_product, :show]

  def index
    @product_details = ProductDetail.all
    render json: @product_details
  end

  def create
    product_details = ProductDetail.new(product_details_params)
    if product_details.save
      render json: product_details, status: :created
    else
      render json: product_details.errors.full_messages
    end
  end

  def image_of_product
    @image = @product_detail.product_colors.first.images[0]
    render json: @image
  end

  def show
    @product_colors = @product_detail.product_colors.pluck(:color)
    @product_size = @product_detail.product_colors.first.products.pluck(:size)
    render json: {
      product_detail: @product_detail,
      product_colors: @product_colors,
      product_size: @product_size
    }
  end


  private 

  def product_details_params
    params.require(:product_detail).permit(:product_name, :description, :cost_price, :selling_price, :brand, :category_id)
  end

  def set_product_detail
    @product_detail = ProductDetail.find_by(id: params[:id])
  end

end
