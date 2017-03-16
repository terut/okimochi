class SessionsController < ApplicationController
  def create
    email = email_params
    if user = User.find_by_email(email)
      if user.magic_link_resendable?
        user.update_magic_link
        UserMailer.magic_link(user).deliver_later
      end
    else
      invitation = Invitation.create_with_token(email)
      UserMailer.invitation(invitation).deliver_later if invitation.present?
    end

    redirect_to login_path
  end

  def validate
    user = User.find_by_magic_link_token(params[:token])
    if user && user.authenticate_with_magic_link
      login(user)
    end

    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  private

  def email_params
    params.require(:email)
  end
end
