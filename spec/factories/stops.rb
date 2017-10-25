FactoryBot.define do
  factory :stop do
    external_id { Faker::Lorem.word }
    name { Faker::Company.name }
    description { Faker::Lorem.sentence }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    station_type { StationTypes::TRAIN }
    wheelchair_boarding true
    diction(en: "18th (Pink Line)", es: "18th (Pink Line)")
  end
end
