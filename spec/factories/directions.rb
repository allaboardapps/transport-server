FactoryGirl.define do
  factory :direction do
    name "North"
    system_identifier "N"
    diction(en: "north", es: "norte")
    fake false
  end
end
