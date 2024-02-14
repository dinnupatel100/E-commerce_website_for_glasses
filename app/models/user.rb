class User < ApplicationRecord
  has_secure_password
  before_save :lowercase_details
  has_many :reviews, dependent: :destroy
  has_many :orders, dependent: :destroy

  
  enum role: {
    customer:"customer",
    admin:"admin"
  }

  validates :first_name, :email, :dob, :mobile_no, :address, :city, :postal_code, presence: true
  validates :email, uniqueness: { case_sensitive: false }, 
            format: { with: /[\w+.-]+@[\w+.-]+/ ,message: "Invalid email format" }
  validates :postal_code, numericality: { greater_than:99999, less_than: 1000000}
  validates :mobile_no, uniqueness: true, length: { minimum:10, maximum:16 },
            format: { with: /\d+/, message: "Mobile number consist of number"}
  validates :password, presence: true, length: {within: 6..15}, on: :create

  private

  def lowercase_details
    first_name.downcase!
    email.downcase!
    address.downcase!
    city.downcase!
  end

end
