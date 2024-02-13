FactoryBot.define do
  factory :product_detail do
    product_name { Faker::Name.unique.name }
    product_description { "Description" }
    cost_price { Faker::Number.between(from: 0.0).round(2) }
    selling_price { Faker::Number.between(from: 0.0).round(2)}
    brand { Faker::Name.name }
    category { FactoryBot.build(:category)}
  end
end
