class AddSlugToItems < ActiveRecord::Migration
  def change
    add_column :items, :slug, :string, index: true
  end
end
