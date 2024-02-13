FactoryBot.define do
  factory :product do
    size { ["M","L","XL"].sample }
    quantity{ Faker::Number.between(from: 1)}
    product_color { FactoryBot.create(:product_color)}
  end
end
