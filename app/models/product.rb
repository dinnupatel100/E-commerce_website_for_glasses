class Product < ApplicationRecord
  belongs_to :product_color
  has_many :orders_products
  has_many :orders, through: :orders_products
end
