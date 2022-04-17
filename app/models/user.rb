class User < ApplicationRecord
  before_save :downcase_email

  belongs_to :organization

  # Validations
  validates :email, presence: true, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :password, presence: true, length: { minimum: 6 }

  private
  
  def downcase_email
    self.email = email.downcase
  end
end
