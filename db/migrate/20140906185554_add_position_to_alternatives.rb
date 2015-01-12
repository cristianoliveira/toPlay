class AddPositionToAlternatives < ActiveRecord::Migration
  def change
    add_column :alternatives, :position, :integer
  end
end
