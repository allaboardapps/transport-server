class Agency < ApplicationRecord
  validates :name, presence: true

  after_create do
    update(id_shortened: id.slice(0..7))
  end

  has_many :routes
  has_many :stops

  def self.options_for_select
    all.map { |item| [item.name, item.id] }
  end
end
