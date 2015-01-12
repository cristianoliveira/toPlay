class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :topic
      t.references :user
      t.text :description
      t.references :parent_id

      t.timestamps
    end
  end
end
