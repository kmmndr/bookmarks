module Bookmarks
  module IO

    def self.import(filename, user_id)
      bookmarks = Markio::parse(File.open(filename))
      user = User.find(user_id) unless user_id.nil?

      #ActiveRecord::Base.transaction do
        bookmarks.each_with_index do |b, idx|
          last = Folder.by_user(user).create_hierarchy!(b.folders)
          puts "Importing #{idx + 1}/#{bookmarks.count}"
          Bookmark.create(
            title: b.title,
            href: b.href,
            folder: last,
            user: user,
            visited_at: b.last_visit,
            updated_at: b.last_modified,
            created_at: b.add_date
          )
        end
      #end

      bookmarks.count
    end

    def self.export
      fail
    end
  end
end
