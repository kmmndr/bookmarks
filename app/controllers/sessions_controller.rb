class SessionsController < ApplicationController
  def create
    #@user = User.where(auth_hash: auth_hash).first_or_create
    user = User.from_omniauth!(env["omniauth.auth"])

    session[:user_id] = user.id

    return_url = session[:return_to] || root_url
    session[:return_to] = nil
    redirect_to return_url, :notice => "Signed in!"
  end

  def destroy
    #Authentication.delete_all_and_reset
    session[:user_id] = nil
    redirect_to root_path, :notice => :disconnect
  end

  def failure
    redirect_to connect_path, :alert => :connect
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
