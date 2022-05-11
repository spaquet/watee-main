class Quiz < ApplicationRecord
  belongs_to :user
  has_many   :questions, dependent: :destroy

  has_one_attached :image
  has_rich_text    :description

  enum status: { draft: 0, published: 10, archived: 20, flag_for_deletion: 30 }

  validates :title, presence: true
  validates :image, content_type: ['image/png', 'image/jpeg', 'image/jpg', 'image/gif'], 
                    size: { between: 1.kilobyte..5.megabytes , message: 'is not given between size' }

end
