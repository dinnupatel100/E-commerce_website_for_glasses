class ProductDetail < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :product_colors, dependent: :destroy
  belongs_to :category
end
