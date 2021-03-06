class User < ApplicationRecord
  # We do not save the password, but the password diget after generating it using Argon2
  attr_accessor :password
  attr_accessor :current_password

  # Callbacks
  before_save :downcase_email, if: :will_save_change_to_email?
  before_save :generate_password_digest

  # Mailer configuration
  MAILER_FROM_EMAIL = "<Watee Mailer> no-reply@wat.ee"
  CONFIRMATION_TOKEN_EXPIRATION = 1.day
  PASSWORD_RESET_TOKEN_EXPIRATION = 20.minutes

  # Relations
  has_many :quizzes, dependent: :destroy
  has_many :active_sessions, dependent: :destroy
  has_one  :setting, dependent: :destroy

  # Active Storage & Action Text
  has_rich_text    :bio
  has_one_attached :avatar

  # Validations
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :password, presence: true, length: { minimum: 6, maximum: 35 }, on: :create
  validates :avatar, content_type: ['image/png', 'image/jpeg', 'image/jpg', 'image/gif'], 
                    size: { between: 1.kilobyte..5.megabytes , message: 'is not given between size' }

  ## Functions

  # Return the user full name (first + last names)
  def full_name
    (self.first_name.capitalize + " " + self.last_name.capitalize).strip
  end

  # Authenticate the user (aka validates the password)
  def authenticate(password)
    require 'argon2'
    Argon2::Password.verify_password(password, self.password_digest)
  end

  # Update the confirmation status for this user
  def confirm!
    update_columns(confirmed_at: Time.current, confirmed: true)
  end

  # Send a confirmation email to the user
  def send_confirmation_email!
    confirmation_token = signed_id(purpose: :email_confirmation, expires_in: CONFIRMATION_TOKEN_EXPIRATION)
    UserMailer.confirmation(self, confirmation_token).deliver_now
  end

  # Send a password reset email to the user
  def send_password_reset_email!
    password_reset_token = signed_id(purpose: :reset_password, expires_in: PASSWORD_RESET_TOKEN_EXPIRATION)
    UserMailer.password_reset(self, password_reset_token).deliver_now
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