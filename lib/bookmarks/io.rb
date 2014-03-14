module Bookmarks
  module IO

    def self.import(filename)
      bookmarks = Markio::parse(File.open(filename))

      ActiveRecord::Base.transaction do
        bookmarks.each_with_index do |b, idx|
          last = Folder.create_hierarchy!(b.folders)
          puts "Importing #{idx + 1}/#{bookmarks.count}"
          Bookmark.create(
            title: b.title,
            href: b.href,
            folder: last,
            visited_at: b.last_visit,
            updated_at: b.last_modified,
            created_at: b.add_date
          )
        end
      end

      bookmarks.count
    end

    def self.export
      fail
    end
  end
end
