class AddVersionToDBItems < ActiveRecord::Migration
  def change
    add_column :db_items, :version, :string
  end
end
