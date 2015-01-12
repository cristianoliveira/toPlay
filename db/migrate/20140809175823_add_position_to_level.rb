class AddPositionToLevel < ActiveRecord::Migration
  def change
    add_column :levels, :position, :integer
  end
end
