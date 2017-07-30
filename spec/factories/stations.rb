FactoryGirl.define do
  factory :station do
    name "#{Faker::Color.color_name.capitalize} Station"
    station_type { StationType::TRAIN }
    diction({ en: "something", es: "alguna cosa" })
    seed false
  end
end
