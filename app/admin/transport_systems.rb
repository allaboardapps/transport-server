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
    column "Short ID" do |item|
      link_to item.id_shortened, admin_item_path(item) if item.id_shortened.present?
    end
    column :id
    column :name
    column :acronym
    column :diction
    column :updated_at
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :acronym
      f.input :diction
      f.input :fake
    end
    f.actions
  end

  show do |train_line|
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
