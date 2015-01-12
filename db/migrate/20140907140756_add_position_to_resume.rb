class AddPositionToResume < ActiveRecord::Migration
  def change
    add_column :resumes, :position, :integer
  end
end
