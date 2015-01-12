class AddUserToCourse < ActiveRecord::Migration
  def change
    add_reference :courses, :user, index: true
  end
end
