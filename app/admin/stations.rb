ActiveAdmin.register Station do
  menu parent: "Systems", priority: 400

  permit_params :name, :station_type, :diction, :fake

  controller do
    def scoped_collection
      super.includes(:transport_system)
    end
  end

  scope :actives, default: true
  scope :fakes

  config.sort_order = "name asc, created_at desc"

  filter :id_shortened_eq, label: "Short ID"
  filter :id_eq, label: "UUID"
  filter :transport_system, as: :select
  filter :direction, as: :select
  filter :route, as: :select
  filter :name
  filter :mapid
  filter :stopid
  filter :stop_name
  filter :description
  filter :station_type
  filter :fake

  index do
    column "Short ID" do |station|
      link_to station.id_shortened, admin_station_path(station) if station.id_shortened.present?
    end
    column "System" do |station|
      station.transport_system.acronym
    end
    column :name
    column :direction
    column :route
    column :station_type
    column :updated_at
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :transport_system, as: :select
      f.input :direction, as: :select
      f.input :route, as: :select
      f.input :name
      f.input :mapid
      f.input :stopid
      f.input :stop_name
      f.input :description
      f.input :station_type
      f.input :latitude
      f.input :longitude
      f.input :diction, as: :text
      f.input :fake
    end
    f.actions
  end

  show do |station|
    attributes_table do
      row :id_shortened
      row :id
      row :mapid
      row :stopid
      row :transport_system
      row :name
      row :stop_name
      row :description
      row :direction
      row :route
      row :station_type
      row :latitude
      row :longitude
      row :diction
      row :fake
      row :updated_at
      row :created_at
    end
  end
end
