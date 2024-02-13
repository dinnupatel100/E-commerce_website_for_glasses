class ProductColor < ApplicationRecord
  belongs_to :product_detail
  has_many :products, dependent: :destroy
  before_save :lowecase_color

  validates :color, presence: true

  private

  def lowecase_color
    color.downcase!
  end
  
end
