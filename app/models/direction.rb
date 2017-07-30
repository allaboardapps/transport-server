class Direction < ApplicationRecord
  validates :name, presence: true

  def self.seed(name: "North", diction: { en: "north", es: "norte" }, seed: true)
    direction_attrs = {
      name: name,
      diction: diction,
      seed: seed
    }

    direction = new(direction_attrs)
    direction.save!
    direction
  end
end
