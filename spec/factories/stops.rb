FactoryBot.define do
  factory :stop do
    external_id "1234"
    name "18th (54th/Cermak-bound)"
    description "18th (Pink Line)"
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    station_type { StationTypes::TRAIN }
    wheelchair_boarding true
    directions [DirectionNames::NORTH, DirectionNames::EAST]
    diction(en: "18th (Pink Line)", es: "18th (Pink Line)")
    fake false
  end
end
