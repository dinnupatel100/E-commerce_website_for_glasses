class ProductColorsController < ApplicationController
  before_action :set_product_color#, only: [:]

  def index
    render json: ProductColor.all
  end

  def create
    product_color = ProductColor.new(product_color_params)
    if product_color.save
      render json: product_color, status: :created
    else
      render json: product_color.errors.full_messages
    end
  end

  def product_color_info
    @product_size = @product_color.products.pluck(:size)
    @product_quantity = @product_color.products.pluck(:quantity)
  end

  private

  def product_color_params
    params.require(:product_color).permit(:color, :images, :product_detail_id)
  end

  def set_product_color
    @product_color = ProductColor.find_by(id: params[:id])
  end

end
