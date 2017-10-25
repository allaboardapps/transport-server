class Stop < ApplicationRecord
  validates :name, presence: true

  after_create do
    update(id_shortened: id.slice(0..7))
  end

  belongs_to :route
  belongs_to :agency

  def self.options_for_select
    all.map { |item| [item.name, item.id] }
  end

  def self.name_valid?(name:)
    return false if name.blank?
    return true if ci_name_search(name: name).present?
    false
  end

  def self.stop_id_valid?(stop_id:)
    return false if stop_id.blank?
    return true if find_by(external_id: stop_id).present?
    false
  end

  def self.validate_by_stop_id(stop_id:)
    return { name: Slots::STOP_ID, present: false, valid: false, value: nil } if stop_id.blank?
    return { name: Slots::STOP_ID, present: true, valid: true, value: stop_id } if find_by(stop_id: stop_id).present?
    { name: Slots::STOP_ID, present: true, valid: false, value: stop_id }
  end

  def self.ci_name_search(name:)
    return nil if name.blank?
    find_by("LOWER(name) ILIKE ?", name.downcase)
  end

  def self.render_ssml(slot:)
    if slot[:name] == Slots::STOP_ID
      if !slot[:present]
        "<speak>Which stop i.d.?</speak>"
      elsif slot[:present] && !slot[:valid]
        "<speak>Sorry, I don't know that stop i.d.<break time='1s'/>Stop numbers are five digits long and start with the number 3.<break time='1s'/>Please say a valid stop i.d.</speak>"
      else
        "<speak>There is something wrong with the stop id processing</speak>"
      end
    else
      "<speak>There is something wrong with the stop id processing</speak>"
    end
  end
end
