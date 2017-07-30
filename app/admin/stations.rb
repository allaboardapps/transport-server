ActiveAdmin.register Station do
  menu parent: "Systems", priority: 100

  permit_params :name, :seed

  # controller do
  #   def scoped_collection
  #     super.includes(:transport_system)
  #   end
  # end

  # scope :actives, default: true

  config.sort_order = "name asc, created_at desc"

  # filter :id_shortened_eq, label: "Short ID"
  filter :id_eq, label: "UUID"
  filter :name
  filter :station_type
  filter :seed

  index do
    # selectable_column
    # column "Short ID" do |item|
    #   link_to item.id_shortened, admin_item_path(item) if item.id_shortened.present?
    # end
    column :id
    column :name
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
      f.input :diction
      f.input :seed
    end
    f.actions
  end

  show do |station|
    attributes_table do
      # row "Short ID" do
      #   humanize_uuid(item.id, 8, false)
      # end
      row :id
      row :name
      row :station_type
      row :diction
      row :seed
      row :updated_at
      row :created_at
    end
  end
end
