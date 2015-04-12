class QueueSyncsJob < ActiveJob::Base
  queue_as :default

  def perform()
    offset = 0.minutes
    Character.find_in_batches(batch_size: 25) do |characters|
      characters.each do |character|
        SyncCharacterJob.set(wait: offset).perform_later(character)
      end
      offset += 2.minutes
    end
  end
end
