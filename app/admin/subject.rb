ActiveAdmin.register Subject do
  belongs_to :course
  permit_params :name, :course_id, :position

  config.sort_order = 'position_asc'
  config.paginate = false
  sortable

  index do |subject|
    column :id
    column :name
    column :course
    column :created_at
    column :updated_at
    column :position
    sortable_handle_column
    actions defaults: false do |subject|
      link_to 'Capítulos', admin_subject_levels_path(subject)
    end
    actions
  end

  form do |f|
    f.inputs "Detalhes" do
      f.input :course
      f.input :name
      f.input :position
    end
    f.actions
  end


  after_build do |currm|
    currm.user = current_user
  end
end
