module Slots
  DIRECTION = "direction".freeze
  ROUTE = "route".freeze
  STOP = "stop".freeze
  STOP_ID = "stop_id".freeze

  def self.all
    [
      Slots::DIRECTION,
      Slots::ROUTE,
      Slots::STOP,
      Slots::STOP_ID
    ]
  end
end
