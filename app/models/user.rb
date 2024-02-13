class User < ApplicationRecord
  has_secure_password
  #after_validation :lowercase_details
  has_many :reviews, dependent: :destroy
  has_many :orders, dependent: :destroy

  
  enum role: {
    customer:"customer",
    admin:"admin"
  }

  validates :first_name, :email, :dob, :mobile_no, :address, :city, :postal_code, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :postal_code, numericality: true
  validates :mobile_no, uniqueness: true, length: { minimum:10, maximum:15 }
  validates :password, presence: true, length: {within: 6..15}, on: :create

  private

  def lowercase_details
    first_name.downcase!
    email.downcase!
    address.downcase!
    city.downcase!
  end

end
