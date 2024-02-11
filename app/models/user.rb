class User < ApplicationRecord
  after_validation :lowercase_name
  has_secure_password
  has_many :reviews, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :first_name, presence: true

  private 

  def lowercase_name
    first_name.downcase!
    # email.downcase!
  end
end
