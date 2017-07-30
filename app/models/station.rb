class Station < ApplicationRecord
  validates :name, presence: true

  belongs_to :transport_system

  def self.seed(
    name: "Damen",
    station_type: StationTypes::TRAIN,
    diction: { en: "damen", es: "damen" },
    seed: true
  )

    station_attrs = {
      name: name,
      station_type: station_type,
      diction: diction,
      seed: seed
    }

    station = new(station_attrs)
    station.save!
    station
  end
end
