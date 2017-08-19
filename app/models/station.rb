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

  def self.validate_by_stopid(stopid:)
    return { name: Slots::STATION_ID, present: false, valid: false, value: nil } if stopid.blank?
    return { name: Slots::STATION_ID, present: true, valid: true, value: stopid } if find_by(stopid: stopid).present?
    { name: Slots::STATION_ID, present: true, valid: false, value: stopid }
  end

  def self.ci_search(name:)
    return nil if name.blank?
    find_by("LOWER(name) ILIKE ?", name.downcase)
  end

  def self.render_ssml(slot:)
    if slot[:name] == Slots::STATION_ID
      if !slot[:present]
        "<speak>Which station i.d.?</speak>"
      elsif slot[:present] && !slot[:valid]
        "<speak>I don't know that station i.d. station numbers are five digits long and start with the number 3</speak>"
      else
        "<speak>There is something wrong with the station id processing</speak>"
      end
    else
      "<speak>There is something wrong with the station id processing</speak>"
    end
  end
end
