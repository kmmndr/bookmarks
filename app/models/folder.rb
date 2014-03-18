class Folder < ActiveRecord::Base
  belongs_to :parent_folder, :class_name => "Folder"
  belongs_to :user
  has_many :sub_folders, :class_name => 'Folder', :inverse_of => :parent_folder, :foreign_key => 'parent_folder_id'
  has_many :bookmarks

  scope :first_level, lambda { with_parent(nil) }
  scope :with_parent, lambda { |parent| where(parent_folder_id: parent.try(:id)) }
  scope :ordered_by_name, lambda { order(name: :asc) }
  scope :owned_by_someone, lambda { where.not(user_id: nil) }
  scope :by_user, lambda { |user| where(user_id: user.try(:id)) }

  def ancestors
    parent_folder.nil? ? [name] : parent_folder.ancestors.dup.insert(-1, name)
  end

  def full_path(char = '/')
    ancestors.join(char)
  end


  def self.create_hierarchy(folders, parent = nil, options = {})
    remaining_folders = folders.dup
    first = remaining_folders.shift
    user = options[:user]

    unless first.nil?
      obj = self.with_parent(parent).where(name: first, user_id: user.try(:id)).first_or_initialize
      obj.save if obj.new_record? && options[:force_create]
#binding.pry
      return create_hierarchy(remaining_folders, obj, options) unless remaining_folders.empty?
    end

    obj
  end

  def self.create_hierarchy!(folders, parent = nil, options = {})
    create_hierarchy(folders, parent, options.merge(force_create: true))
  end

  def exists?
    !new_record?
  end
end
