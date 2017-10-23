ActiveAdmin.register Stop do
  menu parent: "Systems", priority: 800

  permit_params(
    :id_shortened,
    :external_id,
    :code,
    :name,
    :description,
    :latitude,
    :longitude,
    :zone_id,
    :url,
    :location_type,
    :parent_stop,
    :timezone,
    :wheelchair_boarding,
    :stop_id,
    :route_id,
    :stop_type,
    :agency_id,
    :directions,
    :diction
  )

  controller do
    def scoped_collection
      super.includes(:agency)
    end
  end

  config.sort_order = "agency_id asc, name asc, created_at desc"

  filter :id_shortened_eq, label: "Short ID"
  filter :id_eq, label: "UUID"
  filter :agency, as: :select
  filter :route, as: :select
  filter :code
  filter :name
  filter :location_type
  filter :station_type

  index do
    column "Short ID" do |stop|
      link_to stop.id_shortened, admin_stop_path(stop) if stop.id_shortened.present?
    end
    column "Agency" do |stop|
      link_to stop.agency.acronym, admin_stop_path(stop.agency)
    end
    column :code
    column :name
    column :station_type
    column :updated_at
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :agency, as: :select
      f.input :external_id, as: :select
      f.input :code
      f.input :name
      f.input :description
      f.input :latitude
      f.input :longitude
      f.input :zone_id
      f.input :url
      f.input :location_type
      f.input :station_type
      f.input :parent_station
      f.input :timezone
      f.input :wheelchair_boarding
      f.input :station_id
      f.input :agency_id
      f.input :directions
      f.input :diction, as: :text
    end
    f.actions
  end

  show do |stop|
    attributes_table do
      row :id_shortened
      row :agency
      row :external_id
      row :code
      row :name
      row :description
      row :latitude
      row :longitude
      row :zone_id
      row :url
      row :location_type
      row :station_type
      row :parent_station
      row :timezone
      row :wheelchair_boarding
      row :station_id
      row :agency_id
      row :directions
      row :diction, as: :text
      row :updated_at
      row :created_at
    end
  end
end
