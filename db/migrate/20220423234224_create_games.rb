class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string  :name,      null: false
      t.bigint  :user_id,   null: false
      t.boolean :shareable, null: false, default: false
      t.boolean :public,    null: false, default: false
      t.integer :limit,     null: false, default: 20
      t.integer :status, null: false, default: 0

      t.timestamps

      t.index :user_id
      t.index :status
      t.index :shareable
      t.index :public
    end
  end
end
