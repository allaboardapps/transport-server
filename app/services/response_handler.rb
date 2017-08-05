class ResponseHandler
  def self.process(request)
    # direction_phrase = "#{response[:direction]}bound"
    # line_phrase = "#{response[:line]} line train"
    # station_phrase = "#{response[:station]} station"

    # ssml = response[:arrivals].map.with_index do |arrival, index|
    #   intro_phrase = intro_phrasing(index)
    #   arrival_phrase = arrival_phrasing(arrival[:minutes_out])
    #   "<p>#{intro_phrase} #{direction_phrase} #{line_phrase} should arrive at the #{station_phrase} in #{arrival_phrase}.</p>"
    # end.join("")

    if request[:state] == "in_progress"
      request
    elsif request[:state] == "completed"
      direction_phrase = request[:content][:direction]
      route_phrase = request[:content][:route]
      station_phrase = request[:content][:station]
      ssml = "<speak>"\
          "<p>direction #{direction_phrase}</p>"\
          "<p>route #{route_phrase}</p>"\
          "<p>station #{station_phrase}</p>"\
        "</speak>"

      { state: "completed", content: ssml }
    end
  end

  # def self.arrival_phrasing(minutes_out)
  #   if minutes_out == 1
  #     "#{minutes_out} minute"
  #   else
  #     "#{minutes_out} minutes"
  #   end
  # end

  # def self.intro_phrasing(index)
  #   if index.zero?
  #     "The next"
  #   elsif index == 1
  #     "A following"
  #   elsif index == 2
  #     "A third"
  #   end
  # end
end
