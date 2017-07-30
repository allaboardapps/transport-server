class Route < ApplicationRecord
  validates :name, presence: true

  def self.seed(name: "Red Line", seed: true)
    route_attrs = {
      name: name,
      pronunciation: "red line",
      seed: seed
    }

    route = new(route_attrs)
    route.save!
    route
  end
end
