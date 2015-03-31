ActiveAdmin.register Level do
  menu priority: 2 
  belongs_to :subject
  permit_params :name, :subject_id, :position

  config.sort_order = 'position_asc'
  config.paginate = false
  sortable

  index do |level|
    column :id
    column :name
    column :subject
    column :created_at
    column :updated_at
    column :position
    sortable_handle_column
    actions defaults: false do |level|
      link_to 'Conteúdos', admin_level_topics_path(level)
    end
    actions
  end

  form do |f|
    f.inputs "Detalhes" do
      f.input :name
      f.input :subject
      f.input :position
    end
    f.actions
  end


  after_build do |currm|
    currm.user = current_user
  end

end
