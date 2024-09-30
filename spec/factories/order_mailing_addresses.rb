FactoryBot.define do
  factory :order_mailing_address do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { '西市' }
    address { '東区南町1-1' }
    building_name { 'マンション東西南北' }
    phone_number { '09012345678' }
  end
end
