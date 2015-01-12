ActiveAdmin.register User do
  menu priority: 1
  permit_params :first_name, :last_name, :email, :password, :password_confirmation, :role, :gender, :city, :birthdate

  controller do
    def update_resource(object, attributes)
      update_method = attributes.first[:password].present? ? :update_attributes : :update_without_password
      object.send(update_method, *attributes)
    end
  end

  index do
    column :email
    column :last_sign_in_at
    column :sign_in_count
    column :role do |r|
      case r.role
      when 'student'
        "Estudante"
      when 'moderator'
        "Moderador"
      when 'administrator'
        "Administrador"
      else
        r.role
      end
    end
    actions
  end

  filter :email

  form do |f|
    f.inputs "Detalhes" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role, as: :radio, collection: { Estudante: 'student', Moderador: 'moderator', Administrador: 'administrator' }
      f.input :gender, as: :select, collection: User::GENDERS
      f.input :city
      f.input :birthdate
    end
    f.actions
  end
end
