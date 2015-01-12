class CreateAlternatives < ActiveRecord::Migration
  def change
    create_table :alternatives do |t|
      t.text :description
      t.boolean :correct
      t.references :exercise, index: true

      t.timestamps
    end
  end
end
