class UserMailer < ApplicationMailer

  default from: User::MAILER_FROM_EMAIL

  # Send a confirmation email to the user
  def confirmation(user, confirmation_token)
    @user = user
    @confirmation_token = confirmation_token

    mail to: @user.email, subject: "Confirmation Instructions"
  end

  # Send a password reset email to the user
  def password_reset(user, password_reset_token)
    @user = user
    @password_reset_token = password_reset_token

    mail to: @user.email, subject: "Password Reset Instructions"
  end
end
