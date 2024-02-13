Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check
  
  # User routes
  post 'user/login',  to: 'users#login'
  post 'user/signup', to: 'users#create'
  get 'user/data' ,   to: 'users#index'    
  put 'user/:id',     to: 'users#update'   
  get 'user/:id',     to: 'users#show'

  #Category routes
  post 'category/add-category', to: 'categories#add_category'
  get 'category/data', to: 'categories#index'
  delete 'category/:id', to: 'categories#destroy'
  put 'category/:id', to: 'categories#update'
  get 'category/:id',  to: 'categories#show_category_products'

  #Product Details routes
  post 'category/:id/product/add-product', to: 'product_details#create'
  get 'product/data', to: 'product_details#index'
  get 'product/:id', to: 'product_details#show'
  post 'product/search', to: 'product_details#search_result'
  delete 'product/:id', to: 'product_details#destroy'

  #Product Colors routes
  post 'product/:id/product-color/add-color', to: 'product_colors#create'
  delete 'product/product-color/:id', to: 'product_colors#destroy'

  #Product size routes
  get 'product/product-color/product-size/data', to: 'products#index'
  post 'product/product-color/:id/product-size/add-size', to: 'products#create'
  delete 'product/product-color/product-size/:id', to: 'products#destroy'

  #Review routes
  post 'product/:id/review/add-review', to: 'reviews#create'
  get 'product/:id/reviews', to: 'reviews#show_product_reviews'

  #Orders routes
  get 'order/data', to:'orders#index'
  post 'order/add-to-cart', to: 'orders#add_to_cart'
  get 'order/view-cart', to: 'orders#view_cart'
  get "order/place-order/", to: 'orders#order_placed'
  get "order/remove-product", to: 'orders#remove_product_from_cart'
  get "order/remove-all-products", to: 'orders#remove_all_products_from_cart'
  get "order/all-orders", to: 'orders#show_all_orders'
  #Orders_Product routes
  get 'orders_product/data', to: "orders_products#index"

  # Defines the root path route ("/")
  # root "posts#index"
end
