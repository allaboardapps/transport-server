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

    if request[:intent][:slots][Slots::DIRECTION]["value"].empty?
      { state: "in_progress", content: Slots::DIRECTION }
    elsif request[:intent][:slots][Slots::ROUTE]["value"].empty?
      { state: "in_progress", content: Slots::ROUTE }
    elsif request[:intent][:slots][Slots::STATION]["value"].empty?
      { state: "in_progress", content: Slots::STATION }
    else
      slot_values = {
        direction: request[:direction],
        route: request[:route],
        station: request[:station]
      }

      { state: "completed", content: slot_values }
    end
  end
end
