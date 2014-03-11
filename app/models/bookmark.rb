class Bookmark < ActiveRecord::Base
  belongs_to :folder

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
