# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170820225307) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"
  enable_extension "pgcrypto"

  create_table "agencies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "id_shortened"
    t.string "external_id", comment: "GTFS agency_id"
    t.string "name", comment: "GTFS agency_name"
    t.string "url", comment: "GTFS agency_url"
    t.string "timezone", comment: "GTFS agency_timezone, http://en.wikipedia.org/wiki/List_of_tz_zones"
    t.string "lang", comment: "GTFS agency_lang, two-letter ISO 639-1 code"
    t.string "phone", comment: "GTFS agency_phone"
    t.string "fare_url", comment: "GTFS agency_fare_url"
    t.string "email", comment: "GTFS agency_email"
    t.string "acronym", comment: "custom"
    t.jsonb "diction", comment: "custom"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "directions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "id_shortened"
    t.uuid "agency_id"
    t.string "name"
    t.string "external_id"
    t.jsonb "diction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "routes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "id_shortened"
    t.string "external_id", comment: "GTFS route_id"
    t.string "name"
    t.string "short_name", comment: "GTFS route_short_name"
    t.string "long_name", comment: "GTFS route_long_name"
    t.string "description", comment: "GTFS route_desc"
    t.integer "route_type", comment: "0 - 7, type of transportation used on a route"
    t.string "url", comment: "GTFS route_url"
    t.string "color", comment: "GTFS route_color"
    t.string "color_hex", comment: "GTFS route_text_color, 6-char hexadecimal number"
    t.uuid "agency_id", comment: "custom"
    t.jsonb "diction", comment: "custom"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "session_logs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "id_shortened"
    t.float "version"
    t.string "intent_name"
    t.boolean "session_new"
    t.string "session_id"
    t.string "application_id"
    t.string "user_id"
    t.string "request_id"
    t.string "slot_station_id"
    t.string "slot_station_name"
    t.string "slot_direction"
    t.string "slot_route"
    t.string "ssml"
    t.string "slot_to_elicit"
    t.string "template"
    t.boolean "should_end_session"
    t.jsonb "payload_request_body"
    t.jsonb "request_body"
    t.jsonb "payload_response_body"
    t.jsonb "response_body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "cta_response_body"
  end

  create_table "stations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "id_shortened"
    t.string "external_id"
    t.uuid "agency_id"
    t.uuid "direction_id"
    t.uuid "route_id"
    t.string "name"
    t.integer "mapid"
    t.integer "stopid"
    t.string "stop_name"
    t.string "description"
    t.string "latitude"
    t.string "longitude"
    t.string "station_type"
    t.jsonb "diction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stops", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "id_shortened"
    t.string "external_id", comment: "GTFS stop_id"
    t.string "code", comment: "GTFS stop_code"
    t.string "name", comment: "GTFS stop_name"
    t.string "description", comment: "GTFS stop_desc"
    t.string "latitude", comment: "GTFS stop_lat"
    t.string "longitude", comment: "GTFS stop_lon"
    t.string "zone_id"
    t.string "url", comment: "GTFS stop_url"
    t.integer "location_type", comment: "0: Stop, 1: Station, 2: Station Entrace/Exit"
    t.string "parent_station"
    t.string "timezone", comment: "GTFS agency_timezone, http://en.wikipedia.org/wiki/List_of_tz_zones"
    t.integer "wheelchair_boarding", comment: "0: no accessibility info, 1: wheelchair might use, 2: wheelchair boarding is not possible"
    t.uuid "station_id", comment: "custom"
    t.uuid "route_id", comment: "custom"
    t.string "station_type", comment: "custom"
    t.uuid "agency_id", comment: "custom"
    t.string "directions", default: [], comment: "custom", array: true
    t.jsonb "diction", comment: "custom"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end


  create_view "cta_train_locations", materialized: true,  sql_definition: <<-SQL
      SELECT row_number() OVER () AS id,
      stops.name AS stop_name,
      stations.name AS station_name,
      routes.name AS route_name,
      directions.name AS direction_name,
      stops.external_id AS stop_external_id,
      stations.external_id AS station_external_id,
      routes.external_id AS route_external_id,
      directions.external_id AS direction_external_id,
      stops.id AS stop_id,
      stations.id AS station_id,
      routes.id AS route_id,
      directions.id AS direction_id,
      stations.diction AS station_diction,
      stops.diction AS stop_diction,
      routes.diction AS route_diction,
      directions.diction AS direction_diction
     FROM (((stops
       LEFT JOIN stations ON ((stations.id = stops.station_id)))
       JOIN directions ON ((directions.id = stations.direction_id)))
       JOIN routes ON ((routes.id = stations.route_id)));
  SQL

end
