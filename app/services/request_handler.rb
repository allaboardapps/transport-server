class RequestHandler
  def self.process(_)
    CtaTrainTracker.request(40380)

    # response["ctatt"]["eta"]
    # station_name = staNm
    # station_desc = stpDe
    # route = rt
    # arrival_time = arrT

    {
      line: "brown",
      direction: "north",
      station: "<phoneme alphabet='ipa' ph='dɛmen'>Damen</phoneme>",
      arrivals: [
        {
          minutes_out: 1
        },
        {
          minutes_out: 13
        },
        {
          minutes_out: 22
        }
      ]
    }
  end
end
