class User < ApplicationRecord
  # We do not save the password, but the password diget after generating it using Argon2
  attr_accessor :password

  # Callbacks
  before_save :downcase_email, if: :will_save_change_to_email?
  before_save :generate_password_digest
  after_validation :generate_confirmation_token, on: :create

  # Mailer configuration
  MAILER_FROM_EMAIL = "no-reply@bredshop.com"

  # Relations
  belongs_to :organization, optional: true

  # Validations
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :password, presence: true, length: { minimum: 6, maximum: 35 }, on: :create

  # Update the confirmation status for this user
  def confirm!
    update_columns(confirmed_at: Time.current, confirmed: true)
  end

  private
  
  # Make sure we save all emails in lowercase
  def downcase_email
    self.email = email.downcase
  end
  
  # Generate a confirmation token for this user
  def generate_confirmation_token
    # Generate the token & expiration date
    self.confirmation_token = Digest::UUID.uuid_v4
    self.confirmation_token_expiration = Time.current + 1.day

    # Send the confirmation email
    send_confirmation_email!
  end

  # Hash the password using Argon2
  def generate_password_digest
    require 'argon2'
    if password.present?
      self.password_digest = Argon2::Password.create(password)
    end
  end

  # Send a confirmation email to the user
  def send_confirmation_email!
    UserMailer.confirmation(self).deliver_now
  end

end