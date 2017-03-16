class UserMailer < ApplicationMailer
  def invitation(invitation)
    @invitation = invitation
    mail to: @invitation.email,
         subject: "Complete your Okimochi account registration"
  end

  def magic_link(user)
    @user = user
    mail to: @user.email,
         subject: "Log in to Okimochi"
  end
end
