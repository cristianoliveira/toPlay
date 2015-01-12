class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :cover
      t.text :description
      t.references :topic, index: true

      t.timestamps
    end
  end
end
