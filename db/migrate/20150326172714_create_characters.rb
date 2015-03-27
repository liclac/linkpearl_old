class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.integer :lodestone_id, limit: 8
      t.string :first_name
      t.string :last_name
      t.string :world

      t.timestamps null: false
    end
  end
end
