FactoryGirl.define do
  factory :station do
    name "#{Faker::Color.color_name.capitalize} Station"
    station_type { StationTypes::TRAIN }
    diction(en: "something", es: "alguna cosa")
    fake false
  end
end
