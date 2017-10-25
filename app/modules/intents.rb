module Intents
  NEXT_TRAIN = "NextTrain".freeze
  STOP_DIRECT = "StopDirect".freeze

  def self.all
    [
      Intents::NEXT_TRAIN,
      Intents::STOP_DIRECT
    ]
  end
end
