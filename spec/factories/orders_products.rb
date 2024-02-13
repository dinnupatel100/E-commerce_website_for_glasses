FactoryBot.define do
  factory :orders_product do
    quantity { Faker::Number.between(from:1)}
    order { FactoryBot.create(:order) }
    product { FactoryBot.create(:product) }
  end
end
