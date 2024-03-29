class Bookmark < ActiveRecord::Base
  include Authority::Abilities

  self.authorizer_name = 'BookmarkAuthorizer'

  belongs_to :folder
  belongs_to :user

  scope :by_folder, lambda { |folder| where(folder_id: folder.try(:id)) }
  scope :by_folders, lambda { |folders|
    last = Folder.create_hierarchy(folders)
    where(folder_id: last.try(:id))
  }
  scope :ordered_by_title, lambda { order(updated_at: :asc) }
  scope :owned_by_someone, lambda { where.not(user_id: nil) }
  scope :by_user, lambda { |user| where(user_id: user.try(:id)) }


  def auto_title
    title || href
  end

  def update_title
    self.title = get_title(href)
    self.save
  end

  def folders
    folder.full_path
  end

  def folders=(path)
    logger.debug "yo"
  end

  private

  def crowl(url, &block)
    agent = Mechanize.new { |conf|
      conf.user_agent_alias = 'Mac Safari'
    }

    agent.get(url) do |page|
      yield page if block_given?
    end
  end

  def get_title(url)
    title = nil

    crowl(url) do |page|
      title = page.title
    end

    title
  end
end
