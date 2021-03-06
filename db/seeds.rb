# CREATE Agencies
puts "BEGIN: Create agency"
file_path = Rails.root.join("db", "imports", "cta_agency.csv")
csv_text = open(file_path)
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  Agency.create_with(
    external_id: row["agency_id"],
    name: row["agency_name"],
    url: row["agency_url"],
    timezone: row["agency_timezone"],
    lang: row["agency_lang"],
    phone: row["agency_phone"],
    fare_url: row["agency_fare_url"],
    diction: { en: "c.t.a.", es: "c.t.a." },
    acronym: "CTA"
  ).find_or_create_by(name: row["agency_name"])
end

agency = Agency.first
puts "END:   Create Agency, Actives Count: #{Agency.all.count}"

# CREATE Directions
puts "BEGIN: Create directions"
directions = [
  { agency_id: agency.id, name: "north", external_id: "n", diction: { en: "north", es: "norte" } },
  { agency_id: agency.id, name: "east", external_id: "e", diction: { en: "east", es: "este" } },
  { agency_id: agency.id, name: "south", external_id: "s", diction: { en: "south", es: "sur" } },
  { agency_id: agency.id, name: "west", external_id: "w", diction: { en: "west", es: "oeste" } },
]
directions.each do |direction|
  Direction.create_with(direction).find_or_create_by(name: direction[:name])
end
puts "END:   Create directions, Actives Count: #{Direction.all.count}"

# CREATE Routes
puts "BEGIN: Create routes (via import)"
file_path = Rails.root.join("db", "imports", "cta_routes.csv")
csv_text = open(file_path)
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  if row["route_type"] == RouteTypes::TRAIN
    Route.create_with(
      agency: agency,
      external_id: row["route_id"],
      name: row["route_long_name"],
      short_name: row["route_short_name"],
      description: row["route_long_name"],
      route_type: row["route_type"],
      route_url: row["route_url"],
      diction: { en: row["route_long_name"], es: row["route_long_name"] },
      color_hex: row["route_color"]
    ).find_or_create_by(agency: agency, external_id: row["route_id"])
  end
end
puts "END:   Create routes, Actives Count: #{Route.all.count}"

# CREATE Stops
puts "BEGIN: Create stops (via import)"
file_path = Rails.root.join("db", "imports", "cta_stops_trains_brown.csv")
csv_text = open(file_path)
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  direction = Direction.find_by(name: row["direction_name"])
  route = Route.find_by(external_id: row["route_name"])

  if direction && route
    Stop.create_with(
      agency: agency,
      direction: direction,
      route: route,
      external_id: row["stop_id"],
      code: row["stop_code"],
      name: row["stop_name"],
      description: row["stop_desc"],
      latitude: row["stop_lat"],
      longitude: row["stop_lon"],
      location_type: row["location_type"],
      parent_station: row["parent_station"],
      timezone: row["timezone"],
      station_type: StationTypes::TRAIN,
      wheelchair_boarding: row["wheelchair_boarding"],
      diction: { en: row["stop_name"], es: row["stop_name"] }
    ).find_or_create_by(agency_id: agency.id, external_id: row["stop_id"])
    puts "ACTION: Creating stop #{row["stop_id"]}"
  end
end
puts "END:   Create stops, Actives Count: #{Stop.all.count}"

# REFRESH Materialized Views
puts "BEGIN: Refresh Mat Views"
CtaTrainLocation.refresh
puts "END:   Refresh Mat Views"
