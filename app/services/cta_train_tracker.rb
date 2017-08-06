class CtaTrainTracker
  def self.request(mapid:)
    api_key = ENV["CTA_TRAIN_TRACKER_API_KEY"]
    url = "#{AppSettings.cta_train_tracker_base_url}?key=#{api_key}&mapid=#{mapid}" # 40380
    response = RestClient.get(url)
    Hash.from_xml(response)
  end

  def self.get_mapid(route:, station:, direction:)
    CtaTrainLocation.find_by(route: route, station: station, direction: direction)
  end
end
