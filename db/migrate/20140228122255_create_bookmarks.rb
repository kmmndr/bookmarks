class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string :title
      t.string :href
      t.datetime :visited_at

      t.timestamps
    end
  end
end
