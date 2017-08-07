class Station < ApplicationRecord
  validates :name, presence: true

  after_create do
    update(id_shortened: id.slice(0..7))
  end

  belongs_to :direction
  belongs_to :route
  belongs_to :transport_system

  scope :actives, -> { where(fake: false) }
  scope :fakes, -> { where(fake: true) }

  def self.options_for_select
    all.map { |item| [item.name, item.id] }
  end

  def self.name_valid?(name:)
    return false if name.blank?
    return true if ci_search(name: name).present?
    false
  end

  def self.stopid_valid?(stopid:)
    return false if stopid.blank?
    return true if find_by(stopid: stopid).present?
    false
  end

  def self.ci_search(name:)
    return nil if name.blank?
    find_by("LOWER(name) ILIKE ?", name.downcase)
  end
end
