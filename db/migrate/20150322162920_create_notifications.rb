class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user, index: true
      t.string :title
      t.string :message
      t.string :url
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
