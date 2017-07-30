FactoryGirl.define do
  factory :station do
    name "18th (54th/Cermak-bound)"
    system_identifier "30162"
    stop_name "18th (54th/Cermak-bound)"
    description "18th (Pink Line)"
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    station_type { StationTypes::TRAIN }
    diction(en: "18th 54th Cermak bound", es: "18th 54th Cermak bound")
    fake false
  end
end
