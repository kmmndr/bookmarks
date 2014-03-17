class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  add_menu "home", :root_path

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authenticate
    unless current_user
      #unauthorized access
      session[:return_to] = request.fullpath
      redirect_to login_url
      return false
    end
  end

end
