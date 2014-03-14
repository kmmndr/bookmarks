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

    Bookmarks::IO.import(args.filename)
  end
  task :import => :environment

end
