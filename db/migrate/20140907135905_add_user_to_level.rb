class AddUserToLevel < ActiveRecord::Migration
  def change
    add_reference :levels, :user, index: true
  end
end
