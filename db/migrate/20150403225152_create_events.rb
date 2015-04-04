class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :group
      t.string :name
      t.time :time
      
      t.timestamps null: false
    end
  end
end
