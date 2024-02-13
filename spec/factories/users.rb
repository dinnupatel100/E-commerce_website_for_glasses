FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name}
    email { Faker::Internet.email }
    password { "password123" }
    dob {Faker::Date.birthday}
    mobile_no { Faker::PhoneNumber.cell_phone }
    address {Faker::Address.full_address }
    city { Faker::Address.city }
    postal_code { 411017 }
  end
end
