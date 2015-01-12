class CreateResumes < ActiveRecord::Migration
  def change
    create_table :resumes do |t|
      t.text :description
      t.references :topic, index: true

      t.timestamps
    end
  end
end
