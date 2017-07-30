class Station < ApplicationRecord
  validates :name, presence: true

  def self.seed(name: "Damen", seed: true)
    station_attrs = {
      name: name,
      pronunciation: "damen",
      seed: seed
    }

    station = new(station_attrs)
    station.save!
    station
  end
end
