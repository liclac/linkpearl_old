class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.references :belongs_to, polymorphic: true, index: true
      t.string :title
      t.text :description
      t.datetime :closes_at

      t.timestamps null: false
    end
  end
end
