class CreateGameStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :game_statuses do |t|
      t.bigint  :game_id,     null: false
      t.bigint  :game_mgr_id, null: false # Id of the user who manages this instance of the game
      t.string  :pin,         null: false # Unique pin for each game instance
      t.integer :status,      null: false, default: 0
      t.timestamp :start_time
      t.timestamp :end_time
      t.boolean   :close_game_after_last_question, null: false, default: false 
      t.boolean   :sync_players,                   null: false, default: false
      t.boolean   :allow_unregistered_player,      null: false, default: true
      t.integer   :highest_score
      t.bigint    :highest_score_player_id
      t.timestamp :highest_score_last_updated_at

      t.timestamps

      t.index :game_mgr_id
      t.index :game_id
      t.index :pin, unique: true
      t.index :status
      t.index :allow_unregistered_player
      t.index :highest_score_player_id
      t.index :sync_players
      t.index :close_game_after_last_question
    end
  end
end
