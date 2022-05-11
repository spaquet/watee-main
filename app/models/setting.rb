class Setting < ApplicationRecord
  before_create :default_values

  belongs_to :user

  enum theme: {
    "light": 0,
    "dark": 1,
    "cupcake": 2,
    "emerald": 3,
    "corporate": 4,
    "synthwave": 5,
    "valentine": 6,
    "halloween": 7,
    "garden": 8,
    "aqua": 9,
    "pastel": 10,
    "fantasy": 11,
    "wireframe": 12,
    "luxury": 13,
    "business": 14,
    "acid": 15,
    "lemonade": 16,
    "night": 17,
    "coffee": 18,
    "winter": 19,
  }

  private

  def default_values
    self.theme = 0
    self.lang = 'en'
  end

end
