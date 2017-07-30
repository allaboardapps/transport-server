class Direction < ApplicationRecord
  validates :name, presence: true

  def self.seed(name: "North", seed: true)
    direction_attrs = {
      name: name,
      pronunciation: "north",
      seed: seed
    }

    direction = new(direction_attrs)
    direction.save!
    direction
  end
end
