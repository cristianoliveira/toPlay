ActiveAdmin.register Topic do
  belongs_to :level
  permit_params :name, :level_id, :description, :position

  config.sort_order = 'position_asc'
  config.paginate = false
  sortable

  index do
    column :id
    column :name
    column :level
    column :description
    column :created_at
    column :updated_at
    column :position
    sortable_handle_column
    actions defaults: false do |topic|
      link_to 'Vídeos', admin_topic_videos_path(topic)
    end
    actions defaults: false do |topic|
      link_to 'Resumos', admin_topic_resumes_path(topic)
    end
    actions defaults: false do |topic|
      link_to 'Exercícios', admin_topic_exercises_path(topic)
    end
    actions defaults: false do |topic|
      link_to 'Questões', admin_topic_questions_path(topic)
    end
    actions
  end

  form do |f|
    f.inputs "Detalhes" do
      f.input :level
      f.input :name
      f.input :description
      f.input :position
    end
    f.actions
  end

  after_build do |currm|
    currm.user = current_user
  end

end
