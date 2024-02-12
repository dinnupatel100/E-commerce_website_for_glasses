class Product < ApplicationRecord
  belongs_to :product_color
  has_many :orders_products, dependent: :destroy
  has_many :orders, through: :orders_products ,dependent: :destroy

  validates :size, presence: true
end
