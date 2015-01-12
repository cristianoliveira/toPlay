class AddPositionToExercises < ActiveRecord::Migration
  def change
    add_column :exercises, :position, :integer
  end
end
