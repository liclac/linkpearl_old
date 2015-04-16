class LodestoneUpdateJob < ActiveJob::Base
  queue_as :default
  
  CONNECTION_POOL = ConnectionPool.new(:size => 5, :timeout => 10) { Faraday.new }
  
  def perform(thing, *args)
    CONNECTION_POOL.with do |connection|
      thing.lodestone_update(*args, connection: connection)
      thing.synced_at = DateTime.now
      thing.save!
    end
  end
end
