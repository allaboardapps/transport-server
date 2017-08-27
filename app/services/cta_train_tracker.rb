class CtaTrainTracker
  def self.request(stop_id:, route_id:, max: 3, payload_format: "JSON")
    api_key = ENV["CTA_TRAIN_TRACKER_API_KEY"]
    url = "#{AppSettings.cta_train_tracker_base_url}?key=#{api_key}&stpid=#{stop_id}&rt=#{route_id}&max=#{max}&outputType=#{payload_format}"
    response = RestClient.get(url)
    JSON.parse(response)
  end
end
