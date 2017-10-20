ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Transport" do
          ul do
            li link_to "Agencies", admin_agencies_path
            li link_to "Routes", admin_routes_path
            li link_to "Stations", admin_stations_path
            li link_to "Directions", admin_directions_path
          end
        end
        panel "Skills" do
          ul do
            li link_to "Skill Document", api_v1_skills_path
          end
        end
      end
      column do
        panel "Sessions" do
          ul do
            li link_to "Session Logs", admin_session_logs_path
          end
        end
        panel "Tech" do
          ul do
            li link_to "Transport Server Wiki", "https://github.com/allaboardapps/transport-server/wiki", target: "_blank"
            # li link_to "HireFire Monitoring", "/hirefire/#{ENV['HIREFIRE_TOKEN']}/info", target: "_blank" if current_user.admin? && Rails.env.production?
            # li link_to "HireFire Monitoring", "/hirefire/development/info", target: "_blank" if current_user.admin? && Rails.env.development?
            # li link_to "Letter Opener Console", "/letter_opener", target: "_blank" if Rails.env.development?
            li link_to "Rails DB Dashboard", rails_db_path, target: "_blank" if Rails.env.development?
            # li link_to "Sidekiq Dashboard", sidekiq_web_path, target: "_blank"
          end
        end
      end
    end
  end # content
end
