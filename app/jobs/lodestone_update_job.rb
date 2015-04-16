class LodestoneUpdateJob < ActiveJob::Base
  queue_as :default
  
  # Ignore jobs queued for deleted records
  rescue_from ActiveJob::DeserializationError, with: -> {}
  
  # Ignore Lodestone errors, raised mainly from attempts to pull
  # privacy-restricted data; just try again next scheduled update
  rescue_from LodestoneError, with: -> {}
  
  # Quietly back off and retry if the connection pool is exhausted
  rescue_from Timeout::Error do
    retry_job
  end
  
  CONNECTION_POOL = ConnectionPool.new(:size => 3, :timeout => 3) { Faraday.new }
  def perform(thing, *args)
    CONNECTION_POOL.with do |connection|
      thing.lodestone_update(*args, connection: connection)
      thing.synced_at = DateTime.now
      thing.save!
    end
  end
end
