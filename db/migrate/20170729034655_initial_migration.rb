class InitialMigration < ActiveRecord::Migration[5.1]
  def change
    enable_extension "uuid-ossp"
    enable_extension "pgcrypto"

    create_table "train_lines", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.string   "name"
      t.boolean  "seed", default: false
      t.timestamps
    end
  end
end
