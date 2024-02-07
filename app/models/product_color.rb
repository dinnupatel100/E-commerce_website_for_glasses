class ProductColor < ApplicationRecord
  belongs_to :product_detail
  has_many :products, dependent: :destroy
end
