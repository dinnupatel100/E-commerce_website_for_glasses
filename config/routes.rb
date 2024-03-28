Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check
  
  # User routes
  post 'login',  to: 'users#login'
  post 'signup', to: 'users#create'
  get 'getallusers' ,   to: 'users#index'    
  put 'updateuser/:id',     to: 'users#update'   
  get 'getuser/:id',     to: 'users#show'
  delete 'deleteuser/:id',  to: 'users#destroy'

  #Category routes
  post 'addcategory', to: 'categories#add_category'
  get 'getallcategories', to: 'categories#index'
  delete 'deletecategory/:id', to: 'categories#destroy'
  put 'updatecategory/:id', to: 'categories#update'
  get 'getproductsbycategory/:id',  to: 'categories#show_category_products'

  #Product Details routes
  post 'addproduct', to: 'product_details#create'
  get 'getallproducts', to: 'product_details#index'
  get 'getproduct/:id', to: 'product_details#show'
  get 'search', to: 'product_details#search_result'
  delete 'deleteproduct/:id', to: 'product_details#destroy'

  #Product Colors routes
  post 'addproductcolor/:id', to: 'product_colors#create'
  delete 'deleteproductcolor/:id', to: 'product_colors#destroy'
  
  #Product size routes
  post 'addproductsize/:id', to: 'products#create'
  delete 'deleteproductsize/:id', to: 'products#destroy'

  #Review routes
  post 'addproductreview/:id', to: 'reviews#create'
  get 'getproductreviews/:id', to: 'reviews#show_product_reviews'

  #Orders routes
  get 'getallorders', to:'orders#index'
  post 'addtocart', to: 'orders#add_to_cart'
  get 'viewcart', to: 'orders#view_cart'
  get "placeorder", to: 'orders#order_placed'
  get "removeproduct/:productid", to: 'orders#remove_product_from_cart'
  
  # Defines the root path route ("/")
  # root "posts#index"
end