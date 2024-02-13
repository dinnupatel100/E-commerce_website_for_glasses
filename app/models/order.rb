class Order < ApplicationRecord
  belongs_to :user
  has_many :orders_products, dependent: :destroy
  has_many :products, through: :orders_products, dependent: :destroy

  validates :order_status, presence: true
  validates :total_bill, presence: true, numericality: { greater_than_or_equal_to:0.0 }
end
