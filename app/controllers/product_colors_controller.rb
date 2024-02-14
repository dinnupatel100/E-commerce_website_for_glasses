class ProductColorsController < ApplicationController
  before_action :set_product_color, only: [:destroy]

  def create
    product = ProductColor.find_by(color: params[:product_color][:color], product_detail_id: params[:id])
    if product.nil?
      product_color = ProductColor.new(product_color_params.merge(product_detail_id: params[:id]))
      if product_color.save
        render json: product_color, status: :created
      else
        render json: product_color.errors.full_messages, status: :bad_request
      end
    else
      render json: "Color #{params[:product_color][:color]} already added", status: :found
    end
  end

  def destroy
    if @product_color.nil?
      render json: "Product color doesn't exist", status: :not_found
    else
      @product_color.destroy
      render json: "Product color deleted successfully", status: :ok
    end
  end

  def product_color_info
    if product_color.nil?
      render json: "Product color doesn't exist", status: :not_found
    else
      @product_size = @product_color.products
      render json: @product_size, status: :ok
    end
  end

  private

  def product_color_params
    params.require(:product_color).permit(:color, :images)
  end

  def set_product_color
    @product_color = ProductColor.find_by(id: params[:id])
  end

end
