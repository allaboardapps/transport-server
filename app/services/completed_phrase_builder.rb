class CompletedPhraseBuilder
  def self.render_ssml(conn)
    intent = conn[:request][:intent_name]

    if intent == Intents::STATION_DIRECT
      station_id = conn[:request][:slots][:station_id]
      # direction = conn[:request][:slots][:direction]

      location = CtaTrainLocation.find_by(stopid: station_id)
      cta_response_body = CtaTrainTracker.request(mapid: location.mapid)

      session_log = SessionLog.find_by(id: conn[:session_log_id])
      session_log.update(
        cta_response_body: cta_response_body.to_json
      )

      arrivals = cta_response_body["ctatt"]["eta"].select { |arrival| arrival["stpId"] == station_id.to_s }

      direction_phrase = "#{location.direction_name}bound"
      route_phrase = "#{location.route_name} line train"
      station_phrase = "#{location.station_name} station"

      if arrivals.count.zero?
        "<speak>There are currently no trains scheduled train arrivals within the next 30 minutes</speak>"
      else
        ssml = arrivals.map.with_index do |arrival, index|
          intro_phrase = intro_phrasing(index)
          arrival_phrase = arrival_phrasing(arrival)
          "<p>#{intro_phrase} #{direction_phrase} #{route_phrase} should arrive at the #{station_phrase} in #{arrival_phrase}.</p>"
        end.join("")
      end

      ssml
    elsif intent == Intents::NEXT_TRAIN

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
end
