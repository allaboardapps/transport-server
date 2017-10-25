class ResponseHandler
  def self.process(payload)
    intent = payload[:request][:intent_name]

    if intent == Intents::STOP_DIRECT
      stop_id_slot = payload[:request][:slots][:stop_id]
      direction_slot = payload[:request][:slots][:direction]
      stop_id = Stop.validate_by_stopid(stopid: stop_id_slot)
      direction = Direction.validate_by_name(name: direction_slot)

      payload[:response][:slots][:stop_id] = stop_id[:value]
      payload[:response][:slots][:direction] = direction[:value]

      if !stop_id[:valid]
        payload[:response][:ssml] = Stop.render_ssml(slot: stop_id)
        payload[:response][:slot_to_elicit] = Slots::STOP_ID
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
      # stop = params[:intent][:slots][Slots::STOP]

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
      # elsif !Stop.name_valid?(name: stop)
      #   {
      #     intent: Intents::NEXT_TRAIN,
      #     state: AlexaDialogStates::IN_PROGRESS,
      #     content: Slots::STOP
      #   }
      # else
      #   slot_values = {
      #     direction: direction,
      #     route: route,
      #     stop: stop
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
