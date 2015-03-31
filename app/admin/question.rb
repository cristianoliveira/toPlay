ActiveAdmin.register Question do
  belongs_to :topic

  permit_params :name, :level_id, :description, :position

  config.sort_order = 'created_at_asc'
  config.paginate = false
  sortable

  index do
    column :id
    column :topic
    column :user
    column :description
    column :created_at
    column :updated_at
    sortable_handle_column
    actions
  end

  form do |f|
    f.inputs "Detalhes" do
      f.input :user
      f.input :description
    end
    f.actions
  end

  after_build do |currm|
    currm.user = current_user
  end

end
