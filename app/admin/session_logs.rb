ActiveAdmin.register SessionLog do
  menu parent: "Logs", priority: 100

  config.sort_order = "created_at desc"

  filter :id

  index do
    column "Session ID" do |session_log|
      link_to session_log.id_shortened, admin_session_log_path(session_log) if session_log.id_shortened.present?
    end
    column "User ID" do |session_log|
      session_log.shortened_user_id
    end
    column "Request ID" do |session_log|
      session_log.shortened_request_id
    end
    column :intent_name
    column "Station ID", :slot_station_id
    column "Station Name", :slot_station_name
    column "Route", :slot_route
    column "Direction", :slot_direction
    column :created_at
    actions
  end

  show do |session_log|
    attributes_table do
      row :id_shortened
      row :id
      row :version
      row :intent_name
      row :session_new
      row :session_id
      row :application_id
      row :user_id
      row "User ID" do
        session_log.shortened_user_id
      end
      row :request_id
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
      row :should_end_session
      row :request_body do
        "<pre>#{JSON.pretty_generate(JSON.parse(session_log.request_body))}</pre>".html_safe if session_log.request_body.present?
      end
      row :conn_request_body do
        "<pre>#{JSON.pretty_generate(JSON.parse(session_log.conn_request_body))}</pre>".html_safe if session_log.conn_request_body.present?
      end
      row :conn_response_body do
        "<pre>#{JSON.pretty_generate(JSON.parse(session_log.conn_response_body))}</pre>".html_safe if session_log.conn_response_body.present?
      end
      row :response_body do
        "<pre>#{JSON.pretty_generate(JSON.parse(session_log.response_body))}</pre>".html_safe if session_log.response_body.present?
      end
      row :updated_at
      row :created_at
    end
  end
end
