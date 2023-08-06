FactoryBot.define do
  factory :item do
    title              {Faker::Lorem.sentence(word_count: 1)}
    describe           {Faker::Lorem.sentence}
    category_id        {Faker::Number.between(from: 2, to: 11)}
    condition_id       {Faker::Number.between(from: 2, to: 7)}
    shipping_charge_id {Faker::Number.between(from: 2, to: 3)}
    prefecture_id      {Faker::Number.between(from: 2, to: 48)}
    shipping_date_id   {Faker::Number.between(from: 2, to: 4)}
    price              {Faker::Number.between(from: 300, to: 9999999)}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/DSC_2419.jpg'), filename: 'DSC_2419.jpg')
    end
  end
end
