class PhraseBuilder
  def self.create(request)
    intent = request[:intent]

    if intent == Intents::STATION_DIRECT
      station_id = request[:content][:station_id]

      station_phrase = station_id
      mapid_phrase = Station.find_by(stopid: station_id).mapid
      direction_phrase = request[:content][:direction]

      "<speak>"\
        "<p>your station i.d. is #{station_phrase}</p>"\
        "<p>your direction is #{direction_phrase}</p>"\
        "<p>your map i.d. is <say-as interpret-as='digits'>#{mapid_phrase}</say-as></p>"\
        "<p><say-as interpret-as='interjection'>vroom</say-as></p>"\
      "</speak>"
    elsif intent == Intents::NEXT_TRAIN
      direction_phrase = request[:content][:direction]
      route_phrase = request[:content][:route]
      station_phrase = request[:content][:station]

      "<speak>"\
        "<p>your route is #{route_phrase}</p>"\
        "<p>your station is #{station_phrase}</p>"\
        "<p>your direction is #{direction_phrase}</p>"\
        "<say-as interpret-as='interjection'>bam</say-as>"\
      "</speak>"
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

  # direction_phrase = "#{response[:direction]}bound"
  # line_phrase = "#{response[:line]} line train"
  # station_phrase = "#{response[:station]} station"

  # ssml = response[:arrivals].map.with_index do |arrival, index|
  #   intro_phrase = intro_phrasing(index)
  #   arrival_phrase = arrival_phrasing(arrival[:minutes_out])
  #   "<p>#{intro_phrase} #{direction_phrase} #{line_phrase} should arrive at the #{station_phrase} in #{arrival_phrase}.</p>"
  # end.join("")
end
