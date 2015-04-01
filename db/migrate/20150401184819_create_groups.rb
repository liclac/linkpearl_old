class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.text :message
      
      t.timestamps null: false
    end
    
    create_table :characters_groups do |t|
      t.belongs_to :character, index: true
      t.belongs_to :group, index: true
      
      t.timestamps null: false
    end
  end
end
