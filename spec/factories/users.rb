FactoryBot.define do

  factory :user do
    nickname              {Faker::Name.initials(number: 3)}
    email                 {Faker::Internet.email}
    #password              {[('a'..'z').to_a.sample(3) + ('0'..'9').to_a.sample(3)].sample(3).join}
    password              {Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1)}
    password_confirmation {password}
    surname               {Faker::Japanese::Name.last_name}
    givenname             {Faker::Japanese::Name.first_name}
    surname_kana          {('ァ'..'ヶ').to_a.sample(3).join}
    givenname_kana        {('ァ'..'ヶ').to_a.sample(3).join}
    birthday              {Faker::Date.in_date_period(year: 2000)}
  end
end


