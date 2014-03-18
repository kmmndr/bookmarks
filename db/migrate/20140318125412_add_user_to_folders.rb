class AddUserToFolders < ActiveRecord::Migration
  def change
    add_column :folders, :user_id, :integer
    add_index :folders, :user_id
  end
end
