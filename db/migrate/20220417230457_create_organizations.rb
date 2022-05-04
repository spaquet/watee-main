class CreateOrganizations < ActiveRecord::Migration[7.0]
  def change
    create_table :organizations do |t|
      t.string  :name
      t.bigint  :owner_id # reference the owner of the organization
      t.boolean :validated, null: false, default: false
      t.string  :domain

      t.timestamps

      t.index :owner_id
      t.index :name, unique: true
      t.index :validated
      t.index :domain, unique: true
    end
  end
end
