class AddSyncedAtToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :synced_at, :timestamp, null: true
  end
end
