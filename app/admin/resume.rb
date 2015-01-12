ActiveAdmin.register Resume do
  belongs_to :topic
  permit_params :topic_id, :description, :position

  config.sort_order = 'position_asc'
  config.paginate = false
  sortable

  index do |level|
    column :id
    column :topic
    column :description
    column :position
    sortable_handle_column
    actions defaults: false do |level|
      link_to 'Conteúdos', admin_level_topics_path(level)
    end
    actions
  end

  form do |f|
    f.inputs "Detalhes" do
      f.input :topic
      f.input :description
      f.input :position
    end
    f.actions
  end

  after_build do |currm|
    currm.user = current_user
  end

end
