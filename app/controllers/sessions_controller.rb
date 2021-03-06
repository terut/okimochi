class SessionsController < ApplicationController
  include Kagishi

  def create
    email = email_params
    user = User.find_by(email: email)
    if user&.magic_link_resendable?
      user.update_attributes(magic_link_sent_at: Time.current)
      UserMailer.with(user: user, token: issue_token(user.email)).magic_link.deliver_later
    elsif user.nil? && invitation = Invitation.create_with_email(email)
      UserMailer.with(invitation: invitation, token: issue_token(invitation.email)).invitation.deliver_later
    end

    redirect_to login_path
  end

  def auth
    if user = User.find_by(email: verify_token(params[:token])&.email)
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
