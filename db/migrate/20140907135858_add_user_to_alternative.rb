class AddUserToAlternative < ActiveRecord::Migration
  def change
    add_reference :alternatives, :user, index: true
  end
end
