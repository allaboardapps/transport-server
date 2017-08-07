class RequestHandler
  def self.process(request)
    # CtaTrainTracker.request(40380)

    # response["ctatt"]["eta"]
    # station_name = staNm
    # station_desc = stpDe
    # route = rt
    # arrival_time = arrT

    # {
    #   line: "brown",
    #   direction: "north",
    #   station: "<phoneme alphabet='ipa' ph='dɛmen'>Damen</phoneme>",
    #   arrivals: [
    #     {
    #       minutes_out: 1
    #     },
    #     {
    #       minutes_out: 13
    #     },
    #     {
    #       minutes_out: 22
    #     }
    #   ]
    # }
    # request[:intent][:slots][Slots::DIRECTION]["value"]

    if request[:intent] == Intents::STATION_DIRECT
      direction = request[:intent][:slots][Slots::DIRECTION][:value]
      station_id = request[:intent][:slots][Slots::STATION_ID][:value]

      if !Direction.valid?(name: direction)
        {
          intent: Intents::STATION_DIRECT,
          state: AlexaDialogStates::IN_PROGRESS,
          content: Slots::DIRECTION
        }
      elsif !Station.stopid_valid?(stopid: stopid)
        {
          intent: Intents::STATION_DIRECT,
          state: AlexaDialogStates::IN_PROGRESS,
          content: Slots::STATION_ID
        }
      else
        slot_values = {
          direction: direction,
          station: station_id
        }

        {
          intent: Intents::STATION_DIRECT,
          state: AlexaDialogStates::COMPLETED,
          content: slot_values
        }
      end
    elsif request[:intent] == Intents::NEXT_TRAIN
      direction = request[:intent][:slots][Slots::DIRECTION][:value]
      route = request[:intent][:slots][Slots::ROUTE][:value]
      station = request[:intent][:slots][Slots::STATION][:value]

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
  end
end
