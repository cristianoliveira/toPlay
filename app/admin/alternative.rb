ActiveAdmin.register Alternative do

  belongs_to :exercise
  permit_params :exercise_id, :correct, :description, :position

  config.sort_order = 'position_asc'
  config.paginate = false
  sortable

  index do
    column :id
    column :exercise
    column :description
    column :correct do |c|
      case c.correct
      when true
        status_tag "Sim", :ok
      when false
        status_tag "Não", :error
      else
        status_tag "Não", :error
      end
    end

    column :position
    sortable_handle_column
    actions
  end

  form do |f|
    f.inputs "Detalhes" do
      f.input :exercise
      f.input :description
      f.input :correct
      f.input :position
    end
    f.actions
  end

  after_build do |currm|
    currm.user = current_user
  end

end

