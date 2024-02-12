class ProductDetailsController < ApplicationController
  load_and_authorize_resource 
  before_action :set_product_detail, only: [:image_of_product, :show, :destroy]

  def index
    @product_details = ProductDetail.all
    render json: @product_details
  end

  def create
    product_details = ProductDetail.new(product_detail_params.merge(category_id: params[:id]))
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

  def destroy
    @product_detail.destroy
    render json: "Product details deleted successfully"
  end

  def search_result
    @category = Category.where("category_name LIKE ?", "%#{params[:keywords]}%")
    
    if (@category.empty?)
      @products = ProductDetail.where("product_name LIKE ? OR brand LIKE ?", "%#{params[:keywords]}%", "%#{params[:keywords]}%")
    else
      @products = ProductDetail.where("product_name LIKE ? OR brand LIKE ? OR category_id = ?",
                               "%#{params[:keywords]}%", "%#{params[:keywords]}%", "#{@category.first.id}")
    end 
    render json: @products
  end

  private 

  def product_detail_params
    
    params.require(:product_detail).permit(:product_name, :product_description, :cost_price, :selling_price, :brand)
  end

  def set_product_detail
    @product_detail = ProductDetail.find_by(id: params[:id])
  end

end
