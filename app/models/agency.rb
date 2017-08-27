class Agency < ApplicationRecord
  validates :name, presence: true

  after_create do
    update(id_shortened: id.slice(0..7))
  end

  has_many :routes
  has_many :stops
  has_many :stations
  has_many :directions

  scope :actives, -> { where(fake: false) }
  scope :fakes, -> { where(fake: true) }

  def self.options_for_select
    all.map { |item| [item.name, item.id] }
  end
end
