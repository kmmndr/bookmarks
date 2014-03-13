namespace :bookmarks do

  desc "Remove all bookmarks"
  task :empty do |t|
    Folder.delete_all
    Folder.reset_pk_sequence
    Bookmark.delete_all
    Bookmark.reset_pk_sequence
  end
  task :empty => :environment

  desc "Import bookmarks from file"
  task :import, [:filename] do |t, args|
    args.with_defaults(:filename => nil)

    bookmarks = Markio::parse(File.open(args.filename))

    ActiveRecord::Base.transaction do
      bookmarks.each_with_index do |b, idx|
        last = Folder.create_hierarchy!(b.folders)
        puts "Importing #{idx}/#{bookmarks.count}"
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
  end
  task :import => :environment

end
