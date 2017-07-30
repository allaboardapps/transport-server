FactoryGirl.define do
  factory :route do
    name "#{Faker::Color.color_name.capitalize} Line"
    route_type { RouteTypes::TRAIN }
    diction(en: "something", es: "alguna cosa")
    seed false
  end
end
