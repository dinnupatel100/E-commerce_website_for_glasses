class ProductColor < ApplicationRecord
  belongs_to :product_detail
  has_many :products, dependent: :destroy
  after_validation :lowecase_color

  validates :color, presence: true

  private

  def lowecase_color
    color.downcase!
  end
  
end
