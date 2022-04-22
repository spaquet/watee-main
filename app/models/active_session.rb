class ActiveSession < ApplicationRecord
  belongs_to :user

  # Provision a secured token forthe Remember Me feature
  has_secure_token :remember_token
end
