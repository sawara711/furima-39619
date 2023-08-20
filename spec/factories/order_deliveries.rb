FactoryBot.define do
  factory :order_delivery do
    postcode      {('0'..'9').to_a.sample(3).join + '-' + ('0'..'9').to_a.sample(4).join}
    prefecture_id {Faker::Number.between(from: 2, to: 48)}
    city          {Faker::Lorem.word.capitalize}
    address       {Faker::Address.street_address}
    building      {Faker::Lorem.sentence(word_count: 1)}
    phonenumber   {Faker::Number.number(digits: 10).to_s}
    token         {"tok_abcdefghijk00000000000000000"}
  end
end
