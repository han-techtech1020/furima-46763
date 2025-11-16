FactoryBot.define do
  factory :purchase do
    postal_code { Faker::Number.number(digits: 3).to_s + '-' + Faker::Number.number(digits: 4).to_s }
    prefecture_id { rand(2..48) }
    city { Faker::Address.city }
    street { Faker::Address.street_address }
    building { Faker::Address.secondary_address }
    phone_number { Faker::Number.between(from: 1_000_000_000, to: 99_999_999_999).to_s }
    token { 'tok_visa' }

    user_id { FactoryBot.build_stubbed(:user).id }
    item_id { FactoryBot.build_stubbed(:item).id }
  end
end
