class OrdersController < ApplicationController
  load_and_authorize_resource

  def index
    @order = Order.all
    render json: @order
  end

  def show_all_orders
    
  end

  def add_to_cart
    order_id = find_order_id
    if order_id == nil
      Order.create(user_id: current_user.id , order_status: "cart", total_bill: 0.0)
      order_id = find_order_id
    end
    OrdersProduct.create(order_id: order_id, product_id: params[:product_id], quantity: params[:quantity])
    update_cart_total_bill(order_id)
  end

  def view_cart
    order_id = find_order_id
    if order_id == nil
      render json: {message: "Cart is empty. Please add the product"}
    else
      cart_products_details(order_id)
    end
  end

  def remove_product_from_cart
    order_product = OrdersProduct.find_by(product_id: params[:id])
    order_product.destroy
    render json: "Product removed successfully"
  end

  def remove_all_products_from_cart
    order = Order.find_by(user_id: current_user.id, order_status: "cart")
    order.orders_products.destroy
    render json: "All products removed successfully"
  end

  def order_placed
    order = Order.find_by(user_id: current_user.id, order_status: "cart")
    if order == nil
      render json: { message: "You have nothing in your cart to order" }
    else
      order.orders_products.each do |orders_product|
        ordered_quantity = orders_product.quantity
        available_quantity = orders_product.product.quantity
        if ordered_quantity > available_quantity 
          render json: { 
            message: "Product #{orders_product.product.product_color.product_detail.product_name} is not available"
          }
        end
        Product.update(orders_product.product_id, quantity: available_quantity-ordered_quantity)
        price = orders_product.product.product_color.product_detail.selling_price
        orders_product.update(buying_price: price, order_date: Time.now())
      end
      order.update(order_status: "ordered")
      render json: "Your Order Placed Successfully "
    end
  end

  private
  
  def find_order_id
    order  = Order.find_by(user_id: current_user.id , order_status: "cart")
    if order == nil
      nil
    else
      order.id
    end
  end

  def update_cart_total_bill(order_id)
    order = Order.find_by(id: order_id)
    price = Product.find_by(id: params[:product_id]).product_color.product_detail.selling_price
    bill = (order.total_bill) + (price * params[:quantity])
    order.update(total_bill: bill)
  end

  def cart_products_details(order_id)
    @products_array = []
    order_products = Order.find_by(id: order_id).orders_products
      
    order_products.each do |order_product|
      quantity = order_product.quantity
      size = order_product.product.size
      product_detail = order_product.product.product_color.product_detail
      price = product_detail.selling_price 
      name = product_detail.product_name
      color = order_product.product.product_color.color
      @products_array << { 
        product_name: name, 
        color: color, 
        quantity: quantity,
        size: size, 
        price: price, 
        total_price: price*quantity }
    end
    render json: @products_array
  end

end
