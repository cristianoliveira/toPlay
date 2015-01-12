class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.string :name
      t.references :subject, index: true

      t.timestamps
    end
  end
end
