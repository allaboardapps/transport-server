class InitialMigration < ActiveRecord::Migration[5.1]
  def change
    enable_extension "uuid-ossp"
    enable_extension "pgcrypto"

    create_table "transport_systems", id: :uuid do |t|
      t.string   "id_shortened"
      t.string   "name"
      t.string   "acronym"
      t.jsonb    "diction"
      t.boolean  "fake", default: false
      t.timestamps
    end

    create_table "routes", id: :uuid do |t|
      t.string   "id_shortened"
      t.uuid     "transport_system_id"
      t.string   "name"
      t.string   "route_type"
      t.jsonb    "diction"
      t.boolean  "fake", default: false
      t.timestamps
    end

    create_table "stations", id: :uuid do |t|
      t.string   "id_shortened"
      t.uuid     "transport_system_id"
      t.string   "name"
      t.string   "station_type"
      t.jsonb    "diction"
      t.boolean  "fake", default: false
      t.timestamps
    end

    create_table "directions", id: :uuid do |t|
      t.string   "id_shortened"
      t.string   "name"
      t.jsonb    "diction"
      t.boolean  "fake", default: false
      t.timestamps
    end
  end
end
