module DirectionNames
  NORTH = "north".freeze
  EAST = "east".freeze
  SOUTH = "south".freeze
  WEST = "west".freeze

  def self.all
    [
      DirectionNames::NORTH,
      DirectionNames::EAST,
      DirectionNames::SOUTH,
      DirectionNames::WEST
    ]
  end
end
