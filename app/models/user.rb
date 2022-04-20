class User < ApplicationRecord
  # We do not save the password, but the password diget after generating it using Argon2
  attr_accessor :password

  # Callbacks
  before_save :downcase_email, if: :will_save_change_to_email?
  before_save :generate_password_digest

  # Mailer configuration
  MAILER_FROM_EMAIL = "no-reply@bredshop.com"
  CONFIRMATION_TOKEN_EXPIRATION = 1.day

  # Relations
  belongs_to :organization, optional: true

  # Validations
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :password, presence: true, length: { minimum: 6, maximum: 35 }, on: :create

  # Update the confirmation status for this user
  def confirm!
    update_columns(confirmed_at: Time.current, confirmed: true)
  end

  # Send a confirmation email to the user
  def send_confirmation_email!
    confirmation_token = signed_id(purpose: :email_confirmation, expires_in: CONFIRMATION_TOKEN_EXPIRATION)
    UserMailer.confirmation(self, confirmation_token).deliver_now
  end

  private
  
  # Make sure we save all emails in lowercase
  def downcase_email
    self.email = email.downcase
  end

  # Hash the password using Argon2
  def generate_password_digest
    require 'argon2'
    if password.present?
      self.password_digest = Argon2::Password.create(password)
    end
  end

end