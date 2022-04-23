class Game < ApplicationRecord
  belongs_to :user, class_name: "user", foreign_key: "user_id"

  has_one_attached :image
end
