class ResponseHandler
  def self.process(response)
    direction_phrase = "#{response[:direction]}bound"
    line_phrase = "#{response[:line]} line train"
    station_phrase = "#{response[:station]} station"

    ssml = response[:arrivals].map do |arrival|
      arrival_phrase = arrival_phrasing(arrival[:minutes_out])
      "<p>The next #{direction_phrase} #{line_phrase} should arrive at the #{station_phrase} in #{arrival_phrase}.</p>"
    end.join("")

    "<speak>#{ssml}</speak>"
  end

  def self.arrival_phrasing(minutes_out)
    if minutes_out == 1
      "#{minutes_out} minute"
    else
      "#{minutes_out} minutes"
    end
  end
end
