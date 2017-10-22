FactoryBot.define do
  factory :agency do
    external_id { Faker::Company.ein }
    name { Faker::Company.name }
    url { Faker::Internet.url }
    timezone AllowedTimeZones::CENTRAL
    lang "en"
    phone { Faker::PhoneNumber.phone_number }
    fare_url { Faker::Internet.url }
    email { Faker::Internet.email }
    acronym { Faker::Lorem.characters(3).upcase }
    diction(en: "c.t.a.", es: "c.t.a.")
  end
end
