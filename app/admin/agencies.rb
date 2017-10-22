ActiveAdmin.register Agency do
  menu parent: "Systems", priority: 100

  permit_params(
    :external_id,
    :name,
    :url,
    :timezone,
    :lang,
    :phone,
    :fare_url,
    :email,
    :acronym,
    :diction
  )

  config.sort_order = "name asc, created_at desc"

  filter :id_shortened_eq, label: "Short ID"
  filter :id_eq, label: "UUID"
  filter :name
  filter :acronym

  index do
    column "Short ID" do |agency|
      link_to agency.id_shortened, admin_agency_path(agency) if agency.id_shortened.present?
    end
    column :name
    column :acronym
    column :updated_at
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :external_id
      f.input :name
      f.input :url
      f.input :timezone
      f.input :lang
      f.input :phone
      f.input :fare_url
      f.input :email
      f.input :acronym
      f.input :diction, as: :text
    end
    f.actions
  end

  show do |agency|
    attributes_table do
      row :id_shortened
      row :id
      row :external_id
      row :name
      row :url
      row :timezone
      row :lang
      row :phone
      row :fare_url
      row :email
      row :acronym
      row :diction
      row :updated_at
      row :created_at
    end
  end
end
