FactoryBot.define do
  factory :review do
    rating { Faker::Number.between(from: 1.0, to: 5.0).round(2) }
    review_message { "Something is there" }
    user { FactoryBot.build(:user) }
    product_detail { FactoryBot.build(:product_detail) }
  end
end
