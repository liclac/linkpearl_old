class CreateDBItems < ActiveRecord::Migration
  def change
    create_table :db_items do |t|
      t.string :lodestone_id
      t.string :name
      t.text :description
      
      t.integer :ilvl
      t.string :classes
      t.integer :level
      
      t.decimal :attr1
      t.decimal :attr2
      t.decimal :attr3
      t.json :stats
      
      t.boolean :unique
      t.boolean :untradable
      
      t.references :category, index: true
      
      t.timestamp :synced_at
      t.timestamps null: false
    end
  end
end
