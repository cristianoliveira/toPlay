class AddUserToExercise < ActiveRecord::Migration
  def change
    add_reference :exercises, :user, index: true
  end
end
