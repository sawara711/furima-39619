FactoryBot.define do

  factory :user do
    nickname              {Faker::Name.initials(number: 3)}
    email                 {Faker::Internet.email}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    surname               {Faker::Japanese::Name.last_name}
    givenname             {Faker::Japanese::Name.first_name}
    surname_kana          {('ァ'..'ン').to_a.sample(3).join}
    givenname_kana        {('ァ'..'ン').to_a.sample(3).join}
    birthday              {Faker::Date.in_date_period(year: 2000)}
  end
end