class AddCtaResponseToSessionLogger < ActiveRecord::Migration[5.1]
  def change
    add_column :session_logs, :cta_response_body, :jsonb
  end
end
