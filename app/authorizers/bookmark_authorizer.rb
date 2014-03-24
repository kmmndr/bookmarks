class BookmarkAuthorizer < ApplicationAuthorizer
  def self.readable_by?(user)
    false # no one is allowed to view all bookmarks
  end

  def owned_by_user?(user)
    resource.user.id == user.id
  end

  alias_method :'readable_by?', :'owned_by_user?'
  alias_method :'updatable_by?', :'owned_by_user?'
  alias_method :'deletable_by?', :'owned_by_user?'
end
