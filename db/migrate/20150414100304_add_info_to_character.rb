class AddInfoToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :info, :json, null: false, default: {}
  end
end
