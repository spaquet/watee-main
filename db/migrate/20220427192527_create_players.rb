class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :nickname, null: false
      t.string :email # We collect the email for marketing purpose
      t.bigint :user_id

      t.timestamps

      t.index :email
      t.index :user_id
    end
  end
end
