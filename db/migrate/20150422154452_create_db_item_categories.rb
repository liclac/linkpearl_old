class CreateDBItemCategories < ActiveRecord::Migration
  def change
    create_table :db_item_categories do |t|
      t.string :lodestone_id
      t.string :name
      
      t.string :attr1
      t.string :attr2
      t.string :attr3
      
      t.references :parent, index: true
      
      t.timestamp :synced_at
      t.timestamps null: false
    end
  end
end
