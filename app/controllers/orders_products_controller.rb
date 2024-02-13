class OrdersProductsController < ApplicationController

  def index
    render json: OrdersProduct.all
  end


  private
  
  def order_params
    params.require(:orders_product).permit(:quantity, :buying_price, :order_status, :order_date, :product_id, :order_id)
  end
end
