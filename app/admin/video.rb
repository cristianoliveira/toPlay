ActiveAdmin.register Video do
  belongs_to :topic
  permit_params :topic_id, :url, :channel, :title, :description, :position

  config.sort_order = 'position_asc'
  config.paginate = false
  sortable

  index do |subject|
    column :id
    column :topic
    column :url
    column :title
    column :position
    sortable_handle_column
    actions defaults: false do |subject|
      link_to 'Capítulos', admin_subject_levels_path(subject)
    end
    actions
  end

  form do |f|
    f.inputs "Detalhes" do
      f.input :topic
      f.input :url
      f.input :title
      f.input :description
      f.input :position
    end
    f.actions
  end

  after_build do |currm|
    currm.user = current_user
  end

end
