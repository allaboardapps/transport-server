class RequestHandler
  def self.process(params)
    slots = params[:request][:intent][:slots]

    conn = {
      request: {
        version: params[:version],
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

    conn
  end
end
