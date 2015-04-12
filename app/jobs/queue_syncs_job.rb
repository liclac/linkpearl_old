class QueueSyncsJob < ActiveJob::Base
  queue_as :default

  def perform()
    @characters = Character.where('synced_at < ?', Time.now - 2.hours).all
    for character in @characters
      SyncCharacterJob.perform_later character
    end
  end
end
