class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string  :name,      null: false # Name of the game
      t.bigint  :user_id,   null: false # Owner of the game
      t.boolean :shareable, null: false, default: false # do the user allow sharing the game with other users in the same organization
      t.boolean :public,    null: false, default: false # is the game accessible outside of the user's organization if the user belongs to an organization
      t.integer :limit,     null: false, default: 20
      t.integer :status,    null: false, default: 0 # Default to `draft`

      t.timestamps

      t.index :user_id
      t.index :status
      t.index :shareable
      t.index :public
    end
  end
end
