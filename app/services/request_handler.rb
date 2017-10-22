class RequestHandler
  def self.process(params)
    slots = params[:request][:intent][:slots]

    payload = {
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
      version: payload[:request][:version].to_f,
      intent_name: payload[:request][:intent_name],
      session_new: payload[:request][:session_new],
      session_id: payload[:request][:session_id],
      application_id: payload[:request][:application_id],
      user_id: payload[:request][:user_id],
      request_id: payload[:request][:request_id],
      slot_station_id: payload[:request][:slots][:station_id],
      slot_station_name: payload[:request][:slots][:station_name],
      slot_direction: payload[:request][:slots][:direction],
      slot_route: payload[:request][:slots][:route],
      ssml: "",
      slot_to_elicit: "",
      should_end_session: false,
      template: "",
      payload_request_body: payload.to_json,
      request_body: params.to_json,
      payload_response_body: {},
      response_body: {}
    )
    payload[:session_log_id] = session_log.id

    payload
  end
end
