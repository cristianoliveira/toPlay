class AddRoleToUser < ActiveRecord::Migration
  def up
    add_column :users, :role, :string

    User.create do |u|
      u.email = 'admin@example.com'
      u.password = 'password'
      u.role = :administrator
      u.confirmed_at = DateTime.now
    end
  end

  def down
    remove_column :users, :role
  end
end
