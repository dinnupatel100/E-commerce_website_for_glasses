class ProductsController < ApplicationController
  before_action :set_product_size, only: [:destroy]

  def index
    @products = Product.all
    render json: @products
  end

  def create
    product_size = Product.new(product_size_params.merge(product_color_id: params[:id]))
    if product_size.save
      render json: product_size, status: :created
    else
      render json: product_size.errors.full_messages
    end
  end

  def destroy
      @product_size.destroy
      render json: "Product size deleted successfully"
  end

  private
  
  def product_size_params
    params.require(:product_size).permit(:size, :quantity)
  end

  def set_product_size
    @product_size = Product.find_by(id: params[:id])
  end

end
