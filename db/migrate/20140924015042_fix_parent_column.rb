class FixParentColumn < ActiveRecord::Migration
  def change
    rename_column :questions, :parent_id_id, :parent_id

  end
end
