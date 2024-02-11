class OrdersProductsController < ApplicationController
  def index
    render json: OrdersProduct.all
  end

  def create
    order = OrdersProduct.new(order_params)
    if order.save
      if order.order_status == "ordered"
        puts "In ordered"
        product = Product.find_by(id: order.product_id)
        remaining_quantity = product.quantity - order.quantity
        product.update(quantity: remaining_quantity)
      end
      render json: order, status: :created
    else
      render json: order.errors.full_messages
    end
  end

  def add_ordered_product(o_id)
    OrdersProduct.create(order_id: o_id, product_id: params[:product_id], quantity: params[:quantity])
  end

  private
  
  def order_params
    params.require(:orders_product).permit(:quantity, :buying_price, :order_status, :order_date, :product_id, :order_id)
  end
end
