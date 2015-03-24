class AddDefaultValueToRead < ActiveRecord::Migration
  def up
    change_column :notifications, :read, :boolean, :default => false
  end
  def down
    change_column :notifications, :read, :boolean, :default => nil
  end
end
