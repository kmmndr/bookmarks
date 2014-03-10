class AddFolderToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :folder_id, :integer
    add_index :bookmarks, :folder_id
  end
end
