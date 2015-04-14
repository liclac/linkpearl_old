class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|
      t.integer :lodestone_id
      t.string :name
      t.text :description

      t.timestamps null: false
    end
    
    create_table :achievements_characters do |t|
      t.belongs_to :character, index: true
      t.belongs_to :achievement, index: true
      
      t.timestamps null: false
    end
  end
end
