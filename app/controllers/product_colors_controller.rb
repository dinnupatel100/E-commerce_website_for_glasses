class ProductColorsController < ApplicationController
  before_action :set_product_color, only: [:destroy]

  def create
    product = ProductColor.find_by(color: params[:product_color][:color], product_detail_id: params[:id])
    if product.nil?
      product_color = ProductColor.new(product_color_params.merge(product_detail_id: params[:id]))
      if product_color.save
        render json: product_color, status: :created
      else
        render json: product_color.errors.full_messages
      end
    else
      render json: "Color #{params[:product_color][:color]} already added"
    end
  end


  def destroy
    @product_color.destroy
    render json: "Product color deleted successfully"
  end

  def product_color_info
    @product_size = @product_color.products.pluck(:size)
    @product_quantity = @product_color.products.pluck(:quantity)
  end

  private

  def product_color_params
    params.require(:product_color).permit(:color, :images)
  end

  def set_product_color
    @product_color = ProductColor.find_by(id: params[:id])
  end

end
