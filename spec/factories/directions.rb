FactoryGirl.define do
  factory :direction do
    name "North"
    diction(en: "north", es: "norte")
    fake false
  end
end
