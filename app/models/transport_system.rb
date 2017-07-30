class TransportSystem < ApplicationRecord
  validates :name, presence: true

  has_many :routes
  has_many :stations

  def self.seed(name: "Chicago Transit Authority", seed: true)
    transport_system_attrs = {
      name: name,
      diction: { en: "c.t.a", es: "c.t.a." },
      seed: seed
    }

    transport_system = new(transport_system_attrs)
    transport_system.save!
    transport_system
  end
end
