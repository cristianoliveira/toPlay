ActiveAdmin.register Exercise do
  belongs_to :topic
  permit_params :topic_id, :cover, :description, :position

  config.sort_order = 'position_asc'
  config.paginate = false
  sortable

  index do
    column :id
    column :cover do |exercise|
      image_tag exercise.cover_url(:list)
    end
    column :description
    column :position
    sortable_handle_column
    actions defaults: false do |exercise|
      link_to 'Alternativas', admin_exercise_alternatives_path(exercise)
    end
    actions
  end


  form(:html => { :multipart => true }) do |f|
    f.inputs "Detalhes" do
      f.input :topic
      f.input :description
      f.input :cover, :as => :file, :hint => f.object.cover? ? f.template.image_tag(f.object.cover_url(:thumb)) : ""
    end
    f.actions
  end

  after_build do |currm|
    currm.user = current_user
  end

end
