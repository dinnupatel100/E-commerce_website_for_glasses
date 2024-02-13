FactoryBot.define do
  factory :order do
    order_status { ["cart", "ordered"].sample }
    total_bill { Faker::Number.between(from:0.0).round(2) }
    user {  FactoryBot.create(:user) }
  end
end
