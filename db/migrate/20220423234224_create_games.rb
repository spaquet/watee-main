class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string  :name,      null: false
      t.bigint  :user_id,   null: false
      t.integer :limit,     null: false, default: 20
      t.integer :status_id, null: false, default: 0
      t.text    :description

      t.timestamps

      t.index :user_id
      t.index :status_id
    end
  end
end
