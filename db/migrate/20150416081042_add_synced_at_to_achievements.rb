class AddSyncedAtToAchievements < ActiveRecord::Migration
  def change
    add_column :achievements, :synced_at, :timestamp, null: true
  end
end
