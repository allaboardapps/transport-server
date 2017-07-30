class Route < ApplicationRecord
  validates :name, presence: true

  belongs_to :transport_system

  def self.seed(
    name: "Red Line",
    route_type: RouteTypes::TRAIN,
    diction: { en: "red line", es: "red line" },
    seed: true
  )

    route_attrs = {
      name: name,
      route_type: route_type,
      diction: diction,
      seed: seed
    }

    route = new(route_attrs)
    route.save!
    route
  end
end
