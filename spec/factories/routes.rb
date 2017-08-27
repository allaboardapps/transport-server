FactoryGirl.define do
  factory :route do
    external_id Faker::Lorem.characters(3).upcase
    name "#{Faker::Color.color_name.capitalize} Line"
    short_name Faker::Lorem.characters(5).capitalize
    description "#{Faker::Color.color_name.capitalize} Line"
    route_type RouteTypes::TRAIN
    route_url Faker::Internet.url
    color_hex Faker::Color.hex_color
    diction(en: "something", es: "alguna cosa")
    fake false
  end
end
