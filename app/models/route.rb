class Route < ApplicationRecord
  validates :name, presence: true

  after_create do
    update(id_shortened: id.slice(0..7))
  end

  belongs_to :transport_system

  scope :actives, -> { where(fake: false) }
  scope :fakes, -> { where(fake: true) }
end
