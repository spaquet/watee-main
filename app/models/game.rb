class Game < ApplicationRecord
  belongs_to :user

  has_rich_text :description
  has_one_attached :image
  
  validates :name,  presence: true, length: { maximum: 250 }
  validates :limit, presence: true, numericality: { other_than: 0 }
  validates :image, content_type: ['image/png', 'image/jpeg', 'image/jpg'], 
                    size: { between: 1.kilobyte..10.megabytes , message: 'is not given between size' }
  
  enum :status, { draft: 0, active: 10, archived: 20, trashed: 50 }

end
