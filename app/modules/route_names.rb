module RouteNames
  BLUE = "blue".freeze
  BROWN = "brown".freeze
  GREEN = "green".freeze
  ORANGE = "orange".freeze
  PINK = "pink".freeze
  PURPLE = "purple".freeze
  RED = "red".freeze
  YELLOW = "yellow".freeze

  def self.all
    [
      RouteTypes::BLUE,
      RouteTypes::BROWN,
      RouteTypes::GREEN,
      RouteTypes::ORANGE,
      RouteTypes::PINK,
      RouteTypes::PURPLE,
      RouteTypes::RED,
      RouteTypes::YELLOW
    ]
  end
end
