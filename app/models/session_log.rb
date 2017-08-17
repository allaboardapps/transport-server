class SessionLog < ApplicationRecord
  after_create do
    update(id_shortened: id.slice(0..7))
  end

  def shortened_request_id
    request_id.split(".")[3].slice(0..10) if request_id.present?
  end

  def shortened_user_id
    user_id.split(".")[3].slice(0..10) if user_id.present?
  end
end