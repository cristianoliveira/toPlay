class AddPositionToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :position, :integer
  end
end
