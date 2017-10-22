FactoryBot.define do
  factory :route do
    external_id { Faker::Lorem.characters(3).upcase }
    name { "#{Faker::Color.color_name.capitalize} Line" }
    short_name { Faker::Lorem.characters(5).capitalize }
    long_name { "#{Faker::Color.color_name.capitalize} Line" }
    description { "#{Faker::Color.color_name.capitalize} Line" }
    route_type 1
    url { Faker::Internet.url }
    color { Faker::Color.color_name }
    color_hex { Faker::Color.hex_color }
    diction(en: "something", es: "alguna cosa")
  end
end
