class CreateCtaTrainLocations < ActiveRecord::Migration[5.0]
  def change
    create_view :cta_train_locations, materialized: true
  end
end
