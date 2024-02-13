FactoryBot.define do
  factory :category do
    category_name { Faker::Name.name }
  end
end
