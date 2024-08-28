FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    last_name { ['山田', '佐藤', '田中'].sample } # rubocop:disable Style/WordArray
    first_name { ['太郎', '次郎', '花子'].sample } # rubocop:disable Style/WordArray
    kana_last_name { ['ヤマダ', 'サトウ', 'タナカ'].sample } # rubocop:disable Style/WordArray
    kana_first_name { ['タロウ', 'ジロウ', 'ハナコ'].sample } # rubocop:disable Style/WordArray
    birthday { Faker::Date.birthday }
  end
end
