class InitialMigration < ActiveRecord::Migration[5.1]
  def change
    enable_extension "uuid-ossp"
    enable_extension "pgcrypto"

    create_table "agencies", id: :uuid do |t|
      t.string   "id_shortened"
      t.string   "external_id", comment: "GTFS agency_id"
      t.string   "name", comment: "GTFS agency_name"
      t.string   "url", comment: "GTFS agency_url"
      t.string   "timezone", comment: "GTFS agency_timezone, http://en.wikipedia.org/wiki/List_of_tz_zones"
      t.string   "lang", comment: "GTFS agency_lang, two-letter ISO 639-1 code"
      t.string   "phone", comment: "GTFS agency_phone"
      t.string   "fare_url", comment: "GTFS agency_fare_url"
      t.string   "email", comment: "GTFS agency_email"
      t.string   "acronym", comment: "custom"
      t.jsonb    "diction", comment: "custom"
      t.timestamps
    end

    create_table "directions", id: :uuid do |t|
      t.string   "id_shortened"
      t.uuid     "agency_id"
      t.string   "name"
      t.string   "external_id"
      t.jsonb    "diction"
      t.timestamps
    end

    create_table "routes", id: :uuid do |t|
      t.string   "id_shortened"
      t.string   "external_id", comment: "GTFS route_id"
      t.string   "name"
      t.string   "short_name", comment: "GTFS route_short_name"
      t.string   "long_name", comment: "GTFS route_long_name"
      t.string   "description", comment: "GTFS route_desc"
      t.integer  "route_type", comment: "0 - 7, type of transportation used on a route"
      t.string   "url", comment: "GTFS route_url"
      t.string   "color", comment: "GTFS route_color"
      t.string   "color_hex", comment: "GTFS route_text_color, 6-char hexadecimal number"
      t.uuid     "agency_id", comment: "custom"
      t.jsonb    "diction", comment: "custom"
      t.timestamps
    end

    create_table "stops", id: :uuid do |t|
      t.string   "id_shortened"
      t.string   "external_id", comment: "GTFS stop_id"
      t.string   "code", comment: "GTFS stop_code"
      t.string   "name", comment: "GTFS stop_name"
      t.string   "description", comment: "GTFS stop_desc"
      t.string   "latitude", comment: "GTFS stop_lat"
      t.string   "longitude", comment: "GTFS stop_lon"
      t.string   "zone_id"
      t.string   "url", comment: "GTFS stop_url"
      t.integer  "location_type", comment: "0: Stop, 1: Station, 2: Station Entrace/Exit"
      t.string   "parent_station"
      t.string   "timezone", comment: "GTFS agency_timezone, http://en.wikipedia.org/wiki/List_of_tz_zones"
      t.integer  "wheelchair_boarding", comment: "0: no accessibility info, 1: wheelchair might use, 2: wheelchair boarding is not possible"
      t.uuid     "station_id", comment: "custom"
      t.uuid     "route_id", comment: "custom"
      t.string   "station_type", comment: "custom"
      t.uuid     "agency_id", comment: "custom"
      t.string   "directions", array: true, default: [], comment: "custom"
      t.jsonb    "diction", comment: "custom"
      t.timestamps
    end
  end
end
