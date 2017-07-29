class RequestHandler
  def self.process(request)
    CtaTrainTracker.request(40380)

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
