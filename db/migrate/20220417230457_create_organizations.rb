class CreateOrganizations < ActiveRecord::Migration[7.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.bigint :owner

      t.timestamps

      t.index :owner
      t.index :name, unique: true
    end
  end
end
