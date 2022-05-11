class CreateQuizzes < ActiveRecord::Migration[7.0]
  def change
    create_table :quizzes do |t|
      t.string  :title,    null: false
      t.belongs_to :user,  null: false, foreign_key: true
      t.boolean :public,   null: false, default: false
      t.boolean :timed,    null: false, default: false # is the quiz timed?
      t.integer :time_sec, null: false # quiz time in seconds
      t.integer :status,   null: false, default: 0
      t.boolean :free,     null: false, default: true # is the quiz free?

      t.timestamps

      t.index :status
      t.index :public
      t.index [:user_id, :public, :status]
      t.index [:public, :status]
    end
  end
end
