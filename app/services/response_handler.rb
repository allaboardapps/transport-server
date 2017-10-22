class ResponseHandler
  def self.process(payload)
    intent = payload[:request][:intent_name]

    # station_id = { present: true, valid: true, value: 30126 }
    # station_id = { present: true, valid: false, value: 301 }
    # station_id = { present: false, valid: false, value: nil }

    # if station is blank
    #   Which station id?

    # if station is present, but invalid
    #   I don't know that station ID. Station numbers are five digits long and start with the number 3

    # if direction is blank
    #   What direction?

    # if direction is present, but invalid
    #   I don't know that direction. You can say North, South, East, or West

    if intent == Intents::STATION_DIRECT
      station_id_slot = payload[:request][:slots][:station_id]
      direction_slot = payload[:request][:slots][:direction]
      station_id = Station.validate_by_stopid(stopid: station_id_slot)
      direction = Direction.validate_by_name(name: direction_slot)

      payload[:response][:slots][:station_id] = station_id[:value]
      payload[:response][:slots][:direction] = direction[:value]

      if !station_id[:valid]
        payload[:response][:ssml] = Station.render_ssml(slot: station_id)
        payload[:response][:slot_to_elicit] = Slots::STATION_ID
        payload[:response][:template] = "dialog"
        payload[:response][:should_end_session] = false
      elsif !direction[:valid]
        payload[:response][:ssml] = Direction.render_ssml(slot: direction)
        payload[:response][:slot_to_elicit] = Slots::DIRECTION
        payload[:response][:template] = "dialog"
        payload[:response][:should_end_session] = false
      else
        ssml = CompletedPhraseBuilder.render_ssml(payload)
        payload[:response][:ssml] = ssml
        payload[:response][:template] = "completed"
        payload[:response][:should_end_session] = true
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

    session_log = SessionLog.find_by(id: payload[:session_log_id])
    session_log.update(
      ssml: payload[:response][:ssml],
      slot_to_elicit: payload[:response][:slot_to_elicit],
      should_end_session: payload[:response][:should_end_session],
      template: payload[:response][:template],
      payload_response_body: payload.to_json
    )

    payload
  end
end
