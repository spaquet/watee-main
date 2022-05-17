class Question < ApplicationRecord
  belongs_to :quiz

  # ANSWERS_JSON_SCHEMA = "#{Rails.root}/app/models/schemas/answers.json"
  ANSWERS_JSON_SCHEMA = Rails.root.join('app', 'models' ,'schemas', 'answers.json')

  has_one_attached :image
  has_rich_text    :description

  validates :title, presence: true
  validates :image, content_type: ['image/png', 'image/jpeg', 'image/jpg', 'image/gif'], 
                    size: { between: 1.kilobyte..5.megabytes , message: 'is not given between size' }
  validates :answers, presence: true, json: { schema: ANSWERS_JSON_SCHEMA }

  enum question_type: {
    "single_choice": 0,
    "multiple_choices": 10,
    "true_false": 20,
    "yes_no": 30,
    "fill_in_the_blank": 40,
    "short_answer": 50,
    "drawing": 60,
    "drag_and_drop": 70,
    "matching": 80,
    "ordering": 90,
    "poll": 100
    "audio": 110,
    "video": 120,
    "essay": 130,
  } 

end
