class Route < ApplicationRecord
  validates :name, presence: true

  after_create do
    update(id_shortened: id.slice(0..7))
  end

  belongs_to :agency
  has_many :stations

  scope :actives, -> { where(fake: false) }
  scope :fakes, -> { where(fake: true) }

  def self.options_for_select
    all.map { |item| [item.name, item.id] }
  end

  # TODO: Remove database check for scale (use module)
  def self.valid?(name:)
    return false if name.blank?
    return true if ci_search(name: name).present?
    false
  end

  def self.ci_search(name:)
    return nil if name.blank?
    find_by("LOWER(external_id) ILIKE ?", name.downcase)
  end
end
