FactoryGirl.define do
  factory :agency do
    external_id Faker::Company.ein
    name Faker::Company.name
    acronym Faker::Lorem.characters(3).upcase
    url Faker::Internet.url
    timezone AllowedTimeZones::CENTRAL
    lang "en"
    phone Faker::PhoneNumber.phone_number
    fare_url Faker::Internet.url
    email Faker::Internet.email
    diction(en: "c.t.a.", es: "c.t.a.")
    fake false
  end
end
