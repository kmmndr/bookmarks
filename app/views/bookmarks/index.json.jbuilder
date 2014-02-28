json.array!(@bookmarks) do |bookmark|
  json.extract! bookmark, :id, :title, :href, :visited_at
  json.url bookmark_url(bookmark, format: :json)
end
