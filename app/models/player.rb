class Player < ApplicationRecord
  has_one :user
  has_one_attached :avatar

  validates :name, presence: true
  validates :avatar, content_type: ['image/png', 'image/jpeg', 'image/jpg'], 
                    size: { between: 1.kilobyte..5.megabytes , message: 'is not given between size' }

  
end
