class ProductsController < ApplicationController

  def index
    @products = Product.all
    render json: @products
  end

  def create
    product_size = Product.new(product_size_params)
    if product_size.save
      render json: product_size, status: :created
    else
      render json: product_size.errors.full_messages
    end
  end


  private
  
  def product_size_params
    params.require(:product).permit(:size, :quantity, :product_color_id)
  end

  def set_product_size
    @product_size = Product.find_by(id: params[:id])
  end

end
