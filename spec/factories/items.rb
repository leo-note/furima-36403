FactoryBot.define do
  factory :item do
    name                 { Faker::Name.initials }
    text                 { Faker::Lorem.paragraph }
    category_id          { Faker::Number.between(from: 2, to: 11) }
    status_id            { Faker::Number.between(from: 2, to: 7) }
    postage_defrayer_id  { Faker::Number.between(from: 2, to: 3) }
    prefecture_id        { Faker::Number.between(from: 2, to: 48) }
    day_to_ship_id       { Faker::Number.between(from: 2, to: 4) }
    price                { Faker::Number.between(from: 300, to: 9_999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_dummy.png'), filename: 'test_dummy.png')
    end
  end
end
