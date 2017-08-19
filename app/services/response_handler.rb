class ResponseHandler
  def self.process(conn)
    intent = conn[:request][:intent_name]

    if intent == Intents::STATION_DIRECT
      station_id = conn[:request][:slots][:station_id]
      direction = conn[:request][:slots][:direction]

      if Station.stopid_valid?(stopid: station_id)
        conn[:response][:slots][:station_id] = station_id
      end

      if Direction.valid?(name: direction)
        conn[:response][:slots][:direction] = direction
      end

      if conn[:response][:slots][:station_id].blank?
        conn[:response][:ssml] = "<speak>Which station i.d.?</speak>"
        conn[:response][:slot_to_elicit] = Slots::STATION_ID
        conn[:response][:template] = "dialog"
      elsif conn[:response][:slots][:direction].blank?
        conn[:response][:ssml] = "<speak>Which direction?</speak>"
        conn[:response][:slot_to_elicit] = Slots::DIRECTION
        conn[:response][:template] = "dialog"
      else
        conn[:response][:ssml] = "<speak>We're all good</speak>"
        conn[:response][:template] = "completed"
        conn[:response][:should_end_session] = true
      end
    elsif intent == Intents::NEXT_TRAIN
      # direction = params[:intent][:slots][Slots::DIRECTION]
      # route = params[:intent][:slots][Slots::ROUTE]
      # station = params[:intent][:slots][Slots::STATION]

      # if !Direction.valid?(name: direction)
      #   {
      #     intent: Intents::NEXT_TRAIN,
      #     state: AlexaDialogStates::IN_PROGRESS,
      #     content: Slots::DIRECTION
      #   }
      # elsif !Route.valid?(name: route)
      #   {
      #     intent: Intents::NEXT_TRAIN,
      #     state: AlexaDialogStates::IN_PROGRESS,
      #     content: Slots::ROUTE
      #   }
      # elsif !Station.name_valid?(name: station)
      #   {
      #     intent: Intents::NEXT_TRAIN,
      #     state: AlexaDialogStates::IN_PROGRESS,
      #     content: Slots::STATION
      #   }
      # else
      #   slot_values = {
      #     direction: direction,
      #     route: route,
      #     station: station
      #   }

      #   {
      #     intent: Intents::NEXT_TRAIN,
      #     state: AlexaDialogStates::COMPLETED,
      #     content: slot_values
      #   }
      # end
    end

    session_log = SessionLog.find_by(id: conn[:session_log_id])
    session_log.update(
      ssml: conn[:response][:ssml],
      slot_to_elicit: conn[:response][:slot_to_elicit],
      should_end_session: conn[:response][:should_end_session],
      template: conn[:response][:template],
      conn_response_body: conn.to_json
    )

    conn
  end
end
