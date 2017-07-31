ActiveAdmin.register TransportSystem do
  menu parent: "Systems", priority: 100

  permit_params :name, :acronym, :diction, :fake

  scope :actives, default: true
  scope :fakes

  config.sort_order = "name asc, created_at desc"

  filter :id_shortened_eq, label: "Short ID"
  filter :id_eq, label: "UUID"
  filter :name
  filter :acronym
  filter :fake

  index do
    column "Short ID" do |transport_system|
      link_to transport_system.id_shortened, admin_transport_system_path(transport_system) if transport_system.id_shortened.present?
    end
    column :name
    column :acronym
    column :updated_at
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :acronym
      f.input :diction, as: :text
      f.input :fake
    end
    f.actions
  end

  show do |transport_system|
    attributes_table do
      row :id_shortened
      row :id
      row :name
      row :acronym
      row :diction
      row :fake
      row :updated_at
      row :created_at
    end
  end
end
