class UpdateStaleDataJob < ActiveJob::Base
  queue_as :default
  
  include LodestoneLoadable

  def perform()
    load_game_version
    
    update_db_items
  end
  
  def load_game_version
    doc = lodestone_load
    @ver = doc.css('#eorzea_db .area_footer .right.pt2').first.text.strip.split(' ').last
  end
  
  def update_db_items
    # Update items with data from previous patches, and ones that have never
    # been synced, usually indicating that the sync job was somehow dropped
    DBItem.where('version != ? OR version IS NULL OR synced_at IS NULL', @ver).find_each do |item|
      LodestoneUpdateJob.perform_later item
    end
  end
  
  def lodestone_link
    "http://na.finalfantasyxiv.com/lodestone/playguide/db/item/"
  end
end
