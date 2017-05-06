class UserMailer < ApplicationMailer
  before_action { @invitation, @user, @token = params[:invitation], params[:user], params[:token] }

  def invitation
    mail to: @invitation.email,
         subject: "Complete your Okimochi account registration"
  end

  def magic_link
    mail to: @user.email,
         subject: "Log in to Okimochi"
  end
end
