ActiveAdmin.register SessionLog do
  menu parent: "Logs", priority: 100

  config.sort_order = "created_at_desc"

  filter :id

  index do
    column "App ID" do |session_log|
      session_log.shortened_application_id
    end
    column "User ID" do |session_log|
      session_log.shortened_user_id
    end
    column "Session ID" do |session_log|
      session_log.shortened_session_id
    end
    column "Request ID" do |session_log|
      session_log.shortened_request_id
    end
    column :intent_name
    column :state do |session_log|
      "<span class='session-state #{session_log.session_state}'>#{session_log.session_state}</span>".html_safe
    end
    column "Station ID", :slot_station_id
    column "Station Name", :slot_station_name
    column "Route", :slot_route
    column "Direction", :slot_direction
    column :created_at do |session_log|
      session_log.created_at.in_time_zone("America/Chicago").strftime("%Y-%m-%d %I:%M:%S %p")
    end
    actions
  end

  show do |session_log|
    attributes_table do
      row :id_shortened
      row :id
      row :application_id
      row :user_id
      row :request_id
      row :version
      row :intent_name
      row :should_end_session
      row :session_new
      row :state do
        session_log.session_state
      end
      row "App ID" do
        session_log.shortened_application_id
      end
      row "User ID" do
        session_log.shortened_user_id
      end
      row "Session ID" do
        session_log.shortened_session_id
      end
      row "Request ID" do
        session_log.shortened_request_id
      end
      row :slot_station_id
      row :slot_station_name
      row :slot_direction
      row :slot_route
      row :ssml
      row :slot_to_elicit
      row :template
      row :request_body do
        "<pre>#{JSON.pretty_generate(JSON.parse(session_log.request_body))}</pre>".html_safe if session_log.request_body.present?
      end
      row :payload_request_body do
        "<pre>#{JSON.pretty_generate(JSON.parse(session_log.payload_request_body))}</pre>".html_safe if session_log.payload_request_body.present?
      end
      row :cta_response_body do
        "<pre>#{JSON.pretty_generate(JSON.parse(session_log.cta_response_body))}</pre>".html_safe if session_log.response_body.present?
      end
      row :payload_response_body do
        "<pre>#{JSON.pretty_generate(JSON.parse(session_log.payload_response_body))}</pre>".html_safe if session_log.payload_response_body.present?
      end
      row :response_body do
        "<pre>#{JSON.pretty_generate(JSON.parse(session_log.response_body))}</pre>".html_safe if session_log.response_body.present?
      end
      row :updated_at
      row :created_at
    end
  end
end
