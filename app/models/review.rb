class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product_detail

  validates :rating, presence: true,  numericality: { greater_than_or_equal_to:1, less_than_or_equal_to:5}
  validates :review_message , presence: true
end
