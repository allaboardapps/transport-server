module StationTypes
  BUS = "bus".freeze
  TRAIN = "train".freeze

  def self.all
    [
      StationTypes::BUS,
      StationTypes::TRAIN
    ]
  end
end
