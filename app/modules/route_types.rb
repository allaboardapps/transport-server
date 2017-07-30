module RouteTypes
  BUS = "bus".freeze
  TRAIN = "train".freeze

  def self.all
    [
      RouteTypes::BUS,
      RouteTypes::TRAIN
    ]
  end
end
