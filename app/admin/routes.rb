ActiveAdmin.register Route do
  menu parent: "Systems", priority: 600

  permit_params(
    :external_id,
    :name,
    :short_name,
    :long_name,
    :description,
    :route_type,
    :url,
    :color,
    :color_hex,
    :agency_id,
    :diction
  )

  controller do
    def scoped_collection
      super.includes(:agency)
    end
  end

  config.sort_order = "name asc, created_at desc"

  filter :id_shortened_eq, label: "Short ID"
  filter :id_eq, label: "UUID"
  filter :agency, as: :select
  filter :name
  filter :short_name
  filter :system_identifier
  filter :external_id
  filter :description
  filter :route_type

  index do
    column "Short ID" do |route|
      link_to route.id_shortened, admin_route_path(route) if route.id_shortened.present?
    end
    column "System" do |route|
      link_to route.agency.acronym, admin_agency_path(route.agency)
    end
    column :name
    column :short_name
    column :route_type
    column :updated_at
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :agency, as: :select
      f.input :external_id
      f.input :name
      f.input :short_name
      f.input :long_name
      f.input :description
      f.input :route_type
      f.input :url
      f.input :color
      f.input :color_hex
      f.input :diction, as: :text
    end
    f.actions
  end

  show do |route|
    attributes_table do
      row :id_shortened
      row :id
      row :agency
      row :external_id
      row :name
      row :short_name
      row :long_name
      row :description
      row :route_type
      row :url
      row :color
      row :color_hex
      row :diction
      row :updated_at
      row :created_at
    end
  end
end

