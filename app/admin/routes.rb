ActiveAdmin.register Route do
  menu parent: "Systems", priority: 100

  permit_params :name, :route_type, :diction, :fake

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
  filter :route_type
  filter :fake

  index do
    column "Short ID" do |route|
      link_to route.id_shortened, admin_route_path(route) if route.id_shortened.present?
    end
    column :name
    column "System" do |route|
      route.transport_system.acronym
    end
    column :route_type
    column :diction
    column :updated_at
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :route_type
      f.input :diction, as: :text
      f.input :fake
    end
    f.actions
  end

  show do |route|
    attributes_table do
      row :id_shortened
      row :id
      row :name
      row "System" do
        route.transport_system.acronym
      end
      row :route_type
      row :diction
      row :fake
      row :updated_at
      row :created_at
    end
  end
end
