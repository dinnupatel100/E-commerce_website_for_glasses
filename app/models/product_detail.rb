class ProductDetail < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :product_colors, dependent: :destroy
  belongs_to :category
  before_save :lowercase_product_details

  validates :product_name, :brand, :product_description, presence: true
  validates :product_name, uniqueness: {case_sensitive: false }
  validates :cost_price, presence: true, numericality: { greater_than: 0 }
  validates :selling_price, presence: true, numericality: { greater_than: 0 }

  def lowercase_product_details
    product_name.downcase!
    brand.downcase!
  end

end
