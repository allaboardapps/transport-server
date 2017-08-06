FactoryGirl.define do
  factory :route do
    name "#{Faker::Color.color_name.capitalize} Line"
    system_identifier "Brn"
    lowerid "brown"
    description "Kimball-Loop service"
    route_type { RouteTypes::TRAIN }
    diction(en: "something", es: "alguna cosa")
    fake false
  end
end
