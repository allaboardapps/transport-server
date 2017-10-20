class InitialMigration < ActiveRecord::Migration[5.1]
  def change
    enable_extension "uuid-ossp"
    enable_extension "pgcrypto"

    create_table "agencies", id: :uuid do |t|
      t.string   "id_shortened"
      t.string   "external_id"
      t.string   "name"
      t.string   "acronym"
      t.string   "url"
      t.string   "timezone"
      t.string   "lang"
      t.string   "phone"
      t.string   "fare_url"
      t.string   "email"
      t.jsonb    "diction"
      t.boolean  "fake", default: false
      t.timestamps
    end

    create_table "routes", id: :uuid do |t|
      t.string   "id_shortened"
      t.string   "external_id"
      t.uuid     "agency_id"
      t.string   "name"
      t.string   "short_name"
      t.string   "description"
      t.string   "route_type"
      t.string   "route_url"
      t.string   "color_hex"
      t.jsonb    "diction"
      t.boolean  "fake", default: false
      t.timestamps
    end

    create_table "stops", id: :uuid do |t|
      t.string   "id_shortened"
      t.string   "external_id" #stopid
      t.uuid     "agency_id"
      t.uuid     "station_id" #mapid/parent_station
      t.uuid     "route_id"
      t.string   "name" #stop_name
      t.string   "description" #stop_desc
      t.string   "latitude" #stop_lat
      t.string   "longitude" #stop_long
      t.string   "station_type"
      t.boolean  "wheelchair_boarding"
      t.string   "directions", array: true, default: []
      t.jsonb    "diction"
      t.boolean  "fake", default: false
      t.timestamps
    end

    create_table "stations", id: :uuid do |t|
      t.string   "id_shortened"
      t.string   "external_id"
      t.uuid     "agency_id"
      t.uuid     "direction_id"
      t.uuid     "route_id"
      t.string   "name"
      t.integer  "mapid"
      t.integer  "stopid"
      t.string   "stop_name"
      t.string   "description"
      t.string   "latitude"
      t.string   "longitude"
      t.string   "station_type"
      t.jsonb    "diction"
      t.boolean  "fake", default: false
      t.timestamps
    end

    create_table "directions", id: :uuid do |t|
      t.string   "id_shortened"
      t.uuid     "agency_id"
      t.string   "name"
      t.string   "external_id"
      t.jsonb    "diction"
      t.boolean  "fake", default: false
      t.timestamps
    end
  end
end
