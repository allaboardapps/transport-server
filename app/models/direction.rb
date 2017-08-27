class Direction < ApplicationRecord
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

  def self.validate_by_name(name:)
    return { name: Slots::DIRECTION, present: false, valid: false, value: nil } if name.blank?
    return { name: Slots::DIRECTION, present: true, valid: true, value: name } if ci_search(name: name).present?
    { name: Slots::DIRECTION, present: true, valid: false, value: name }
  end

  def self.ci_search(name:)
    return nil if name.blank?
    find_by("LOWER(name) ILIKE ?", name.downcase)
  end

  def self.render_ssml(slot:)
    if slot[:name] == Slots::DIRECTION
      if !slot[:present]
        "<speak>Which direction?</speak>"
      elsif slot[:present] && !slot[:valid]
        "<speak>Sorry, I don't know that direction.<break time='1s'/>You can say North, South, East, or West. Please say a valid direction.</speak>"
      else
        "<speak>There is something wrong with the direction processing</speak>"
      end
    else
      "<speak>There is something wrong with the direction processing</speak>"
    end
  end
end
