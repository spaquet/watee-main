class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string     :email, null: false
      t.string     :nickname
      t.references :organization, null: true, foreign_key: true
      t.string     :password_digest
      t.boolean    :blocked, null: false, default: false

      # Confirmable
      t.boolean   :confirmed, null: false, default: false
      t.string    :confirmation_token, null: false
      t.timestamp :confirmation_token_expiration, null: false
      t.timestamp :confirmed_at

      # Password reset
      t.string    :password_reset_token
      t.timestamp :password_reset_token_expiration
      t.timestamp :password_reset_at

      # Account is locked
      t.boolean   :locked, null: false, default: false
      t.timestamp :locked_at
      t.integer   :failed_attempts, null: false, default: 0
      

      t.timestamps

      # Indexes
      t.index :email, unique: true
      t.index :nickname
      t.index :blocked
      t.index :confirmed
      t.index :confirmation_token,   unique: true
      t.index :password_reset_token, unique: true
      t.index :locked
    end
  end
end
