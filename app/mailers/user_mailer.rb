class UserMailer < ApplicationMailer

  default from: User::MAILER_FROM_EMAIL

  def confirmation(user)
    @user = user
    @confirmation_token = user.confirmation_token

    mail to: @user.email, subject: "Confirmation Instructions"
  end
end
