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

  create_table "directions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "id_shortened"
    t.uuid "transport_system_id"
    t.string "name"
    t.string "system_identifier"
    t.jsonb "diction"
    t.boolean "fake", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "routes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "id_shortened"
    t.uuid "transport_system_id"
    t.string "name"
    t.string "system_identifier"
    t.string "lowerid"
    t.string "description"
    t.string "route_type"
    t.jsonb "diction"
    t.boolean "fake", default: false
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
    t.jsonb "conn_request_body"
    t.jsonb "request_body"
    t.jsonb "conn_response_body"
    t.jsonb "response_body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "cta_response_body"
  end

  create_table "stations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "id_shortened"
    t.uuid "transport_system_id"
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
    t.boolean "fake", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transport_systems", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "id_shortened"
    t.string "name"
    t.string "acronym"
    t.jsonb "diction"
    t.boolean "fake", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end


  create_view "cta_train_locations", materialized: true,  sql_definition: <<-SQL
      SELECT row_number() OVER () AS id,
      stations.mapid,
      stations.stopid,
      stations.name AS station_name,
      routes.lowerid AS route_name,
      directions.name AS direction_name,
      stations.id AS station_id,
      routes.id AS route_id,
      directions.id AS direction_id,
      stations.diction AS station_diction,
      routes.diction AS route_diction,
      directions.diction AS direction_diction
     FROM ((stations
       JOIN directions ON ((directions.id = stations.direction_id)))
       JOIN routes ON ((routes.id = stations.route_id)))
    WHERE ((stations.fake = false) AND (routes.fake = false) AND (directions.fake = false));
  SQL

end
