module Intents
  NEXT_TRAIN = "NextTrain".freeze
  STATION_DIRECT = "StationDirect".freeze

  def self.all
    [
      Intents::NEXT_TRAIN,
      Intents::STATION_DIRECT
    ]
  end
end
