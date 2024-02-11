Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check
  # User routes
  post '/login',  to: 'users#login'
  post '/signup', to: 'users#create'
  get 'users/data' ,   to: 'users#index'
  delete 'users/:id',  to: 'users#destroy'
  put 'users/:id',     to: 'users#update'
  get 'users/:id',     to: 'users#show'

  #Category routes
  post 'category/add-category', to: 'categories#add_category'
  get 'category/data', to: 'categories#index'
  delete 'category/:id', to: 'categories#destroy'
  put 'category/:id', to: 'categories#update'
  get 'category/:id',  to: 'categories#show_category_products'

  #Product Details routes
  post 'product/add-details', to: 'product_details#add_product_details'
  get 'product/data', to: 'product_details#index'
  get 'product/:id', to: 'product_details#show'

  #Product Colors routes
  get 'product-color/data', to: 'product_colors#index'
  post 'product-color/add-colors', to: 'product_colors#add_product_color'

  #Product size routes
  get 'product-size/data', to: 'products#index'
  post 'product/add-size', to: 'products#add_product_size'


  #Orders routes
  get 'order/data', to:'orders#index'
  post 'order/add-to-cart', to: 'orders#add_to_cart'
  get 'order/view-cart', to: 'orders#view_cart'
  get "order/place-order/", to: 'orders#order_placed'

  #Orders_Product routes
  post 'orders_product/add-item', to: "orders_products#create"
  get 'orders_product/data', to: "orders_products#index"

  # Defines the root path route ("/")
  # root "posts#index"
end
