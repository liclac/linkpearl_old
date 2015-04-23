class RenameDBItemToItem < ActiveRecord::Migration
  def change
    rename_table :db_item_categories, :item_categories
    rename_table :db_items, :items
  end
end
