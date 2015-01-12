class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :city, :string
    add_column :users, :birthdate, :date
    add_column :users, :gender, :integer
  end
end
