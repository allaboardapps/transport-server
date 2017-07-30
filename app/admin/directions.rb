ActiveAdmin.register Direction do
  menu parent: "Systems", priority: 400

  permit_params :name, :diction, :fake

  scope :actives, default: true
  scope :fakes

  config.sort_order = "name asc, created_at desc"

  filter :id_shortened_eq, label: "Short ID"
  filter :id_eq, label: "UUID"
  filter :name
  filter :fake

  index do
    column "Short ID" do |direction|
      link_to direction.id_shortened, admin_direction_path(direction) if direction.id_shortened.present?
    end
    column :name
    column :diction
    column :updated_at
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :diction, as: :text
      f.input :fake
    end
    f.actions
  end

  show do |direction|
    attributes_table do
      row :id_shortened
      row :id
      row :name
      row :diction
      row :fake
      row :updated_at
      row :created_at
    end
  end
end
