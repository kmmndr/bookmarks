class Folder < ActiveRecord::Base
  belongs_to :parent_folder, :class_name => "Folder"
  has_many :sub_folders, :class_name => 'Folder', :inverse_of => :parent_folder, :foreign_key => 'parent_folder_id'
  has_many :bookmarks

  def ancestors
    parent_folder.nil? ? [name] : parent_folder.ancestors.dup.insert(-1, name)
  end

  def full_path(char = '/')
    ancestors.join(char)
  end
end
