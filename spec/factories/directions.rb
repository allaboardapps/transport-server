FactoryBot.define do
  factory :direction do
    name "North"
    external_id "N"
    diction(en: "north", es: "norte")
    fake false
  end
end
