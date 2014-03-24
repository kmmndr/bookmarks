class UserAuthorizer < ApplicationAuthorizer
  def user_is_me?(user)
    resource.id == user.id
  end

  alias_method :'readable_by?', :'user_is_me?'
  alias_method :'updatable_by?', :'user_is_me?'
  alias_method :'deletable_by?', :'user_is_me?'
end
