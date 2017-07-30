ActiveAdmin.register Station do
  menu parent: "Systems", priority: 100

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
  filter :name
  filter :station_type
  filter :fake

  index do
    column "Short ID" do |station|
      link_to station.id_shortened, admin_station_path(station) if station.id_shortened.present?
    end
    column :name
    column "System" do |station|
      station.transport_system.acronym
    end
    column :station_type
    column :diction
    column :updated_at
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :station_type
      f.input :diction, as: :text
      f.input :fake
    end
    f.actions
  end

  show do |station|
    attributes_table do
      row :id_shortened
      row :id
      row "System" do
        station.transport_system.acronym
      end
      row :name
      row :station_type
      row :diction
      row :fake
      row :updated_at
      row :created_at
    end
  end
end
