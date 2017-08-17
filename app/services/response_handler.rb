class ResponseHandler
  def self.process(conn)
    intent = conn[:request][:intent_name]

    if intent == Intents::STATION_DIRECT
      station_id = conn[:request][:slots][:station_id]
      direction = conn[:request][:slots][:direction]

      if !Station.stopid_valid?(stopid: station_id)
        conn[:response][:ssml] = "<speak>Which station i.d.?</speak>"
        conn[:response][:should_end_session] = false
        conn[:response][:slot_to_elicit] = Slots::STATION_ID
        conn[:response][:template] = "dialog"
      elsif !Direction.valid?(name: direction)
        conn[:response][:ssml] = "<speak>Which direction?</speak>"
        conn[:response][:should_end_session] = false
        conn[:response][:slot_to_elicit] = Slots::DIRECTION
        conn[:response][:template] = "dialog"
      else
        conn[:response][:ssml] = "<speak>We're all good</speak>"
        conn[:response][:should_end_session] = true
        conn[:response][:template] = "completed"
      end
    elsif intent == Intents::NEXT_TRAIN
      direction = params[:intent][:slots][Slots::DIRECTION]
      route = params[:intent][:slots][Slots::ROUTE]
      station = params[:intent][:slots][Slots::STATION]

      if !Direction.valid?(name: direction)
        {
          intent: Intents::NEXT_TRAIN,
          state: AlexaDialogStates::IN_PROGRESS,
          content: Slots::DIRECTION
        }
      elsif !Route.valid?(name: route)
        {
          intent: Intents::NEXT_TRAIN,
          state: AlexaDialogStates::IN_PROGRESS,
          content: Slots::ROUTE
        }
      elsif !Station.name_valid?(name: station)
        {
          intent: Intents::NEXT_TRAIN,
          state: AlexaDialogStates::IN_PROGRESS,
          content: Slots::STATION
        }
      else
        slot_values = {
          direction: direction,
          route: route,
          station: station
        }

        {
          intent: Intents::NEXT_TRAIN,
          state: AlexaDialogStates::COMPLETED,
          content: slot_values
        }
      end
    end

    conn
  end
end
