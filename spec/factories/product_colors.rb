FactoryBot.define do
  factory :product_color do
    color { Faker::Name.name }
    product_detail { FactoryBot.create(:product_detail) }
  end
end
