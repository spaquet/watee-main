class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.belongs_to :quiz, null: false, foreign_key: true
      t.string     :title
      t.integer    :question_type, null: false
      t.jsonb      :answers, null: false, default: '{}'

      t.timestamps

      t.index :question_type
    end
  end
end
