class CompletedPhraseBuilder
  def self.render_ssml(conn)
    intent = conn[:request][:intent_name]

    if intent == Intents::STATION_DIRECT
      station_id = conn[:request][:slots][:station_id]
      # direction = conn[:request][:slots][:direction]

      map_id = Station.find_by(stopid: station_id).mapid
      cta_response_body = CtaTrainTracker.request(mapid: map_id)

      session_log = SessionLog.find_by(id: conn[:session_log_id])
      session_log.update(
        cta_response_body: cta_response_body.to_json
      )

      arrivals = cta_response_body["ctatt"]["eta"].select { |arrival| arrival["stpId"] == station_id.to_s }

      if arrivals.count.zero?
        "<speak>There are currently no trains scheduled train arrivals within the next 30 minutes</speak>"
      else
        ssml = arrivals.map.with_index do |arrival, index|
          intro_phrase = intro_phrasing(index)
          arrival_phrase = arrival_phrasing(arrival)
          "<p>#{intro_phrase} #{direction_phrase} #{line_phrase} should arrive at the #{station_phrase} in #{arrival_phrase}.</p>"
        end.join("")
      end
      # "<speak>"\
      #   "<p>your station i.d. is #{station_phrase}</p>"\
      #   "<p>your direction is #{direction_phrase}</p>"\
      #   "<p>your map i.d. is <say-as interpret-as='digits'>#{mapid_phrase}</say-as></p>"\
      #   "<p><say-as interpret-as='interjection'>vroom</say-as></p>"\
      # "</speak>"
      ssml
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

  def self.arrival_phrasing(arrival)
    start_time = Time.current.utc
    end_time = Time.parse(arrival["arrT"]).utc
    duration_in_minutes = TimeDifference.between(start_time, end_time).in_minutes

    if duration_in_minutes <= 1
      "one minute"
    else
      "#{duration_in_minutes} minutes"
    end
  end

  def self.intro_phrasing(index)
    if index.zero?
      "The next"
    elsif index == 1
      "A following"
    elsif index == 2
      "A third"
    end
  end

  # direction_phrase = "#{response[:direction]}bound"
  # line_phrase = "#{response[:line]} line train"
  # station_phrase = "#{response[:station]} station"
end
