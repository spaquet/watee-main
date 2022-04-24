class Game < ApplicationRecord
  belongs_to :user, class_name: "user", foreign_key: "user_id"

  has_one_attached :image
  
  validates :name,  presence: true, length: { maximum: 250 }
  validates :limit, presence: true, numericality: { other_than: 0 }
  validates :image, content_type: [:png, :jpg, :jpeg], size: { between: 1.kilobyte..10.megabytes , message: 'is not given between size' }
  
  enum :status, [ draft: 0, published: 10, archived: 20, trashed: 50 ]
end
