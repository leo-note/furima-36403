FactoryBot.define do
  factory :purchase_history_shipping_address do
    postal_code    { (Faker::Number.number(digits: 7)).to_s.insert(3, '-') }
    prefecture_id  { Faker::Number.between(from: 2, to: 48) }
    city           { Gimei.city.kanji }
    house_number   { Gimei.city.to_s }
    building_name  { Gimei.town.to_s }
    phone_number   { (Faker::Number.number(digits: 10)).to_s }
    token          { 'tok_abcdefghijk00000000000000000' }
  end
end
