class LodestoneUpdateJob < ActiveJob::Base
  queue_as :default

  def perform(thing, *args)
    thing.lodestone_update(*args)
    thing.synced_at = DateTime.now
    thing.save!
  end
end
