FactoryBot.define do
  factory :user do
    nickname { Faker::Name.nickname }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    last_name { Faker::Name.last_name }
    first_name { Faker::Name.first_name }
    kana_last_name { Faker::Name.kana_last_name }
    kana_first_name { Faker::Name.kana_first_name }
    birthday { Faker::Date.birthday }
  end
end
