FactoryGirl.define do
  factory :transport_system do
    name "Chicago Transit Authority"
    diction(en: "c.t.a.", es: "c.t.a.")
    fake false
  end
end
