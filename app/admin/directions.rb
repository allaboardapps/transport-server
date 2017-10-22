ActiveAdmin.register Direction do
  menu parent: "Systems", priority: 200

  permit_params(
    :name,
    :diction
  )

  config.sort_order = "name asc, created_at desc"

  filter :id_shortened_eq, label: "Short ID"
  filter :id_eq, label: "UUID"
  filter :agency, as: :select
  filter :name
  filter :system_identifier

  index do
    column "Short ID" do |direction|
      link_to direction.id_shortened, admin_direction_path(direction) if direction.id_shortened.present?
    end
    column "System" do |station|
      station.agency.acronym
    end
    column :name
    column "SYS ID", :system_identifier
    column :diction
    column :updated_at
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :agency, as: :select
      f.input :name
      f.input :system_identifier
      f.input :diction, as: :text
    end
    f.actions
  end

  show do |direction|
    attributes_table do
      row :id_shortened
      row :id
      row :agency
      row :direction
      row :name
      row :system_identifier
      row :diction
      row :updated_at
      row :created_at
    end
  end
end
