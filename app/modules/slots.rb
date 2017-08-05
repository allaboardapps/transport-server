module Slots
  DIRECTION = "direction".freeze
  ROUTE = "route".freeze
  STATION = "station".freeze

  def self.all
    [
      Slots::DIRECTION,
      Slots::ROUTE,
      Slots::STATION
    ]
  end
end
