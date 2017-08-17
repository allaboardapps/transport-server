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
