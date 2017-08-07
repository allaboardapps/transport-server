module Slots
  DIRECTION = "direction".freeze
  ROUTE = "route".freeze
  STATION = "station".freeze
  STATION_ID = "station_id".freeze

  def self.all
    [
      Slots::DIRECTION,
      Slots::ROUTE,
      Slots::STATION,
      Slots::STATION_ID
    ]
  end
end
