class AddPositionToSubject < ActiveRecord::Migration
  def change
    add_column :subjects, :position, :integer
  end
end
