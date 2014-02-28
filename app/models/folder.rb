class Folder < ActiveRecord::Base
  belongs_to :parent_folder, :class_name => "Folder"
  has_many :sub_folders, :class_name => 'Folder', :inverse_of => :parent_folder, :foreign_key => 'parent_folder_id'
end
