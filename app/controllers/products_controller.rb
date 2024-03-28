class ProductsController < ApplicationController
  before_action :set_product_size, only: [:destroy]
  load_and_authorize_resource

  def create
    product_size = Product.new(product_size_params.merge(product_color_id: params[:id]))
    if product_size.save
      render json:{ message: I18n.t("productsize.addSuccess"),product_size_id: product_size.id}, status: :ok
    else
      render json: {errors: product_size.errors.full_messages}, status: :bad_request
    end
  end

  def destroy
    if @product_size.nil?
      render json: {message: I18n.t("productsize.deleteFailure")}, status: :bad_request
    else
      @product_size.destroy
      render json: {message: I18n.t("productsize.deleteSuccess")}, status: :ok
    end
  end

  private
  
  def product_size_params
    params.require(:product_size).permit(:size, :quantity)
  end

  def set_product_size
    @product_size = Product.find_by(id: params[:id])
  end

end
