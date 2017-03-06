class SessionsController < ApplicationController
  def create
    user = User.find_by_magic_link_token(params[:token])
    if user && user.authenticate_with_magic_link
      session[:user_id] = user.id
    end

    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
