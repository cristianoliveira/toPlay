ActiveAdmin.register Course do
  menu priority: 2
  permit_params :name

  config.sort_order = 'id_asc'

  index do |course|
    column :id
    column :name
    column :created_at
    column :updated_at
    actions defaults: false do |course|
      link_to 'Disciplinas', admin_course_subjects_path(course)
    end
    actions
  end

  form do |f|
    f.inputs "Detalhes" do
      f.input :name
    end
    f.actions
  end

  after_build do |currm|
    currm.user = current_user
  end
end
