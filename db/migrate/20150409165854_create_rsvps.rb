class CreateRSVPs < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.references :character, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true
      
      t.date :date, index: true
      t.boolean :answer
      t.string :comment
      
      t.timestamps null: false
    end
  end
end
