# CREATE TransportSystems
puts "BEGIN: Create transport system"
system = TransportSystem.create_with(
  name: "Chicago Transit Authority",
  acronym: "CTA",
  diction: { en: "c.t.a.", es: "c.t.a." },
  fake: false
).find_or_create_by(name: "Chicago Transit Authority")
puts "END:   Create transport system, Actives Count: #{TransportSystem.actives.count}, Fakes Count: #{TransportSystem.fakes.count}"

# CREATE Directions
puts "BEGIN: Create directions"
directions = [
  { transport_system_id: system.id, name: "North", system_identifier: "N", diction: { en: "north", es: "norte" }, fake: false },
  { transport_system_id: system.id, name: "East", system_identifier: "E", diction: { en: "east", es: "este" }, fake: false },
  { transport_system_id: system.id, name: "South", system_identifier: "S", diction: { en: "south", es: "sur" }, fake: false },
  { transport_system_id: system.id, name: "West", system_identifier: "W", diction: { en: "west", es: "oeste" }, fake: false },
]
directions.each do |direction|
  Direction.create_with(direction).find_or_create_by(name: direction[:name])
end
puts "END:   Create directions, Actives Count: #{Direction.actives.count}, Fakes Count: #{Direction.fakes.count}"

# CREATE Routes
puts "BEGIN: Create routes (via import)"
file_path = Rails.root.join("db", "imports", "cta_routes_2017-07-30.csv")
csv_text = open(file_path)
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  Route.create_with(
    transport_system: system,
    name: row["NAME"],
    system_identifier: row["SYSTEM_IDENTIFIER"],
    description: row["DESCRIPTION"],
    route_type: RouteTypes::TRAIN,
    diction: { en: row["NAME"], es: row["NAME"] },
    fake: false
  ).find_or_create_by(system_identifier: row["SYSTEM_IDENTIFIER"])
end
puts "END:   Create routes, Actives Count: #{Route.actives.count}, Fakes Count: #{Route.fakes.count}"

# CREATE Stations
puts "BEGIN: Create stations (via import)"
file_path = Rails.root.join("db", "imports", "cta_list_of_train_stops_2015-04-30.csv")
csv_text = open(file_path)
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  direction = Direction.find_by(system_identifier: row["DIRECTION_ID"])
  lat_lon = row["Location"].gsub(/[()| ]/, "").split(",")

  test = Station.create_with(
    transport_system: system,
    name: row["STATION_NAME"],
    system_identifier: row["STOP_ID"],
    stop_name: row["STOP_NAME"],
    direction: direction,
    description: row["STATION_DESCRIPTIVE_NAME"],
    latitude: lat_lon[0],
    longitude: lat_lon[1],
    station_type: StationTypes::TRAIN,
    diction: { en: row["STATION_NAME"], es: row["STATION_NAME"] },
    fake: false
  ).find_or_create_by(system_identifier: row["STOP_ID"])
end
puts "END:   Create stations, Actives Count: #{Station.actives.count}, Fakes Count: #{Station.fakes.count}"
