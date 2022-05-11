class CreateSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :settings do |t|
      t.belongs_to  :user,  null: false, index: { unique: true }, foreign_key: true
      t.integer     :theme, null: false, default: 0
      t.string      :lang,  null: false, default: 'en'

      t.timestamps

      # t.index :user_id, unique: true
      t.index :theme
      t.index :lang
    end
  end
end
