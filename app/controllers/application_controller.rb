class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :login?

  private
  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def login(user)
    session[:user_id] = user.id
  end

  def login?
    !!current_user
  end

  def login_required
    return if login?

    redirect_to root_path
  end
end
