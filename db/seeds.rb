# CREATE TransportSystems
puts "BEGIN: Create transport system"
system = TransportSystem.create(
  name: "Chicago Transit Authority",
  acronym: "CTA",
  diction: { en: "c.t.a.", es: "c.t.a." },
  fake: false
)
puts "END:   Create transport system, Test Count: #{TransportSystem.fakes.count}"

# CREATE Directions
puts "BEGIN: Create directions"
Direction.create(
  name: "North",
  diction: { en: "north", es: "norte" },
  fake: false
)
puts "END:   Create directions, Test Count: #{Direction.fakes.count}"

# CREATE Routes
puts "BEGIN: Create routes"
Route.create(
  transport_system: system,
  name: "Brown Line",
  route_type: RouteTypes::TRAIN,
  diction: { en: "brown", es: "brown" },
  fake: false
)
puts "END:   Create routes, Test Count: #{Route.fakes.count}"

# CREATE Stations
puts "BEGIN: Create stations"
Station.create(
  transport_system: system,
  name: "Damen",
  station_type: StationTypes::TRAIN,
  diction: { en: "damen", es: "damen" },
  fake: false
)
puts "END:   Create stations, Test Count: #{Station.fakes.count}"
