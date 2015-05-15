class CreatePollItems < ActiveRecord::Migration
  def change
    create_table :poll_items do |t|
      t.references :poll, index: true, foreign_key: true
      t.integer :position
      t.string :text

      t.timestamps null: false
    end
  end
end
