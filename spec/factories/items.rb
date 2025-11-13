FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence(word_count: 20) }
    price { rand(300..9_999_999) }

    category_id { rand(2..4) }
    condition_id { rand(2..6) }
    shipping_charge_id { rand(2..3) }
    prefecture_id { rand(2..48) }
    shipping_day_id { rand(2..3) }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
