class UserMailer < ApplicationMailer
  def invitation(invitation, token)
    @invitation = invitation
    @token = token
    mail to: @invitation.email,
         subject: "Complete your Okimochi account registration"
  end

  def magic_link(user, token)
    @user = user
    @token = token
    mail to: @user.email,
         subject: "Log in to Okimochi"
  end
end
