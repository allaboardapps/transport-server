class RequestHandler
  def self.process(params)
    slots = params[:request][:intent][:slots]

    conn = {
      session_log_id: "",
      request: {
        version: params[:version],
        session_new: params[:session][:new],
        session_id: params[:session][:sessionId],
        application_id: params[:session][:application][:applicationId],
        user_id: params[:session][:user][:userId],
        request_id: params[:request][:requestId],
        type: params[:request][:type],
        locale: params[:request][:locale],
        timestamp: params[:request][:timestamp],
        intent_name: params[:request][:intent][:name],
        slots: {
          station_id: slots.dig(:station_id, :value),
          station: slots.dig(:station, :value),
          route: slots.dig(:route, :value),
          direction: slots.dig(:direction, :value)
        }
      },
      response: {
        ssml: "",
        slot_to_elicit: "",
        slots: {},
        should_end_session: false,
        template: ""
      }
    }

    session_log = SessionLog.create(
      version: conn[:request][:version].to_f,
      intent_name: conn[:request][:intent_name],
      session_new: conn[:request][:session_new],
      session_id: conn[:request][:session_id],
      application_id: conn[:request][:application_id],
      user_id: conn[:request][:user_id],
      request_id: conn[:request][:request_id],
      slot_station_id: conn[:request][:slots][:station_id],
      slot_station_name: conn[:request][:slots][:station_name],
      slot_direction: conn[:request][:slots][:direction],
      slot_route: conn[:request][:slots][:route],
      ssml: "",
      slot_to_elicit: "",
      should_end_session: nil,
      template: "",
      conn_request_body: conn.to_json,
      request_body: params.to_json,
      conn_response_body: {},
      response_body: {}
    )
    conn[:session_log_id] = session_log.id

    conn
  end
end
