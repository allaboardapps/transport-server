class AddSessionLogModel < ActiveRecord::Migration[5.1]
  def change
    create_table "session_logs", id: :uuid do |t|
      t.string    "id_shortened"
      t.float     "version"
      t.string    "intent_name"
      t.boolean   "session_new"
      t.string    "session_id"
      t.string    "application_id"
      t.string    "user_id"
      t.string    "request_id"
      t.string    "slot_station_id"
      t.string    "slot_station_name"
      t.string    "slot_direction"
      t.string    "slot_route"
      t.string    "ssml"
      t.string    "slot_to_elicit"
      t.string    "template"
      t.boolean   "should_end_session"
      t.jsonb     "payload_request_body"
      t.jsonb     "request_body"
      t.jsonb     "payload_response_body"
      t.jsonb     "response_body"
      t.timestamps
    end
  end
end
