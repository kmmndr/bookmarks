class Bookmark < ActiveRecord::Base
  belongs_to :folder

  def folders
    folder.full_path
  end

  def folders=(path)
    logger.debug "yo"
  end
end
