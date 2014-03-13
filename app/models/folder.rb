class Folder < ActiveRecord::Base
  belongs_to :parent_folder, :class_name => "Folder"
  has_many :sub_folders, :class_name => 'Folder', :inverse_of => :parent_folder, :foreign_key => 'parent_folder_id'
  has_many :bookmarks

  scope :first_level, lambda { with_parent(nil) }
  scope :with_parent, lambda { |parent| where(parent_folder_id: parent.try(:id)) }
  scope :ordered_by_name, lambda { order(name: :asc) }

  def ancestors
    parent_folder.nil? ? [name] : parent_folder.ancestors.dup.insert(-1, name)
  end

  def full_path(char = '/')
    ancestors.join(char)
  end


  def self.create_hierarchy(folders, parent = nil, options = {})
    remaining_folders = folders.dup
    first = remaining_folders.shift

    unless first.nil?
      obj = self.with_parent(parent).where(name: first).first_or_initialize
      obj.save if obj.new_record? && options[:force_create]
      return create_hierarchy(remaining_folders, obj, options) unless remaining_folders.empty?
    end

    obj
  end

  def self.create_hierarchy!(folders, parent = nil, options = {})
    create_hierarchy(folders, parent, force_create: true)
  end

  def exists?
    !new_record?
  end
end
