ActiveAdmin.register CtaTrainLocation do
  menu parent: "Views", priority: 200

  actions :index, :show

  config.sort_order = "route_name asc, created_at desc"

  filter :stop_external_id
  filter :stop_name
  filter :route_external_id
  filter :route_name
  filter :direction_external_id
  filter :direction_name

  index do
    column :mapid
    column "stop id", :stop_external_id
    column :stop_name
    column "rte id", :route_external_id
    column :route_name
    column "dir id", :direction_external_id
    column :direction_name
    actions
  end

  show do |location|
    attributes_table do
      row :id
      row :stop_id
      row :stop_external_id
      row :stop_name
      row :stop_diction
      row :route_id
      row :route_external_id
      row :route_name
      row :route_diction
      row :direction_id
      row :direction_external_id
      row :direction_name
      row :direction_diction
    end
  end
end
