ActiveAdmin.register Route do
  menu parent: "Systems", priority: 300

  permit_params(
    :agency_id,
    :external_id,
    :name,
    :short_name,
    :description,
    :route_type,
    :route_url,
    :color_hex,
    :diction,
    :fake
  )

  controller do
    def scoped_collection
      super.includes(:agency)
    end
  end

  scope :actives, default: true
  scope :fakes

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
  filter :fake

  index do
    column "Short ID" do |route|
      link_to route.id_shortened, admin_route_path(route) if route.id_shortened.present?
    end
    column "System" do |route|
      route.agency.acronym
    end
    column :name
    column :short_name
    column :route_type
    column :diction
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
      f.input :description
      f.input :route_type
      f.input :route_url
      f.input :color_hex
      f.input :diction, as: :text
      f.input :fake
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
      row :description
      row :route_type
      row :route_url
      row :color_hex
      row :diction
      row :fake
      row :updated_at
      row :created_at
    end
  end
end

