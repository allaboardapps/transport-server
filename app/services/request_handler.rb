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

    direction = request[:intent][:slots][Slots::DIRECTION][:value]
    route = request[:intent][:slots][Slots::ROUTE][:value]
    station = request[:intent][:slots][Slots::STATION][:value]

    if direction.blank? || !Direction.valid?()
      { state: "in_progress", content: Slots::DIRECTION }
    elsif route.blank? || !Route.valid?()
      { state: "in_progress", content: Slots::ROUTE }
    elsif station.blank? || !Station.valid?()
      { state: "in_progress", content: Slots::STATION }
    else
      slot_values = {
        direction: direction,
        route: route,
        station: station
      }

      { state: "completed", content: slot_values }
    end
  end
end
