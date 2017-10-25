class Route < ApplicationRecord
  validates :name, presence: true

  after_create do
    update(id_shortened: id.slice(0..7))
  end

  belongs_to :agency
  has_many :stops

  scope :actives, -> { where(fake: false) }
  scope :fakes, -> { where(fake: true) }

  def self.options_for_select
    all.map { |item| [item.name, item.id] }
  end

  # TODO: Remove database check for scale (use module)
  def self.valid?(name:)
    return false if name.blank?
    return true if ci_name_search(name: name).present?
    false
  end

  def self.ci_name_search(name:)
    return nil if name.blank?
    find_by("LOWER(short_name) ILIKE ?", name.downcase)
  end
end
