class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string     :email, null: false
      t.string     :nickname
      t.string     :first_name
      t.string     :last_name
      # t.references :organization, null: true, foreign_key: true
      t.string     :password_digest
      t.boolean    :blocked, null: false, default: false

      # Confirmable
      t.boolean   :confirmed, null: false, default: false
      t.timestamp :confirmed_at

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
      t.index :locked
    end
  end
end
