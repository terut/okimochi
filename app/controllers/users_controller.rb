class UsersController < ApplicationController
  def new
    invitation = Invitation.find_with_valid_token(params[:token])
    redirect_to login_path and return if invitation.blank?

    @token = invitation.token
    @user = User.new({email: invitation.email})
  end

  def create
    invitation = Invitation.find_with_valid_token(params[:invitation_token])
    redirect_to login_path and return if invitation.blank?

    user_attributes = user_params.to_h.reverse_merge({ email: invitation.email })
    @user = User.new(user_attributes)
    if @user.save
      login(@user)
      redirect_to root_path
    else
      @token = invitation.token
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:username)
  end
end
