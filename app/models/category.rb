class Category < ApplicationRecord
  has_many :product_details, dependent: :destroy
  
  validates :category_name, presence: true, uniqueness: { case_sensitive: false }
end
