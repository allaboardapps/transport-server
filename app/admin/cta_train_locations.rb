ActiveAdmin.register CtaTrainLocation do
  menu parent: "Views", priority: 200

  actions :index, :show

  config.sort_order = "station_name asc, created_at desc"

  filter :mapid
  filter :stopid
  filter :station_name
  filter :route_name
  filter :direction_name

  index do
    column :mapid
    column :stopid
    column :station_name
    column :route_name
    column :direction_name
    actions
  end

  show do |location|
    attributes_table do
      row :id
      row :mapid
      row :stopid
      row :station_id
      row :station_name
      row :station_diction
      row :route_id
      row :route_name
      row :route_diction
      row :direction_id
      row :direction_name
      row :direction_diction
    end
  end
end
