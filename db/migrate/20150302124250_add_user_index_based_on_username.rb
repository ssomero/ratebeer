class AddUserIndexBasedOnUsername < ActiveRecord::Migration
  def change
    add_index :user, :username
  end
end
