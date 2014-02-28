class AddParentFolderToFolders < ActiveRecord::Migration
  def change
    add_column :folders, :parent_folder_id, :integer
    add_index :folders, :parent_folder_id
  end
end
