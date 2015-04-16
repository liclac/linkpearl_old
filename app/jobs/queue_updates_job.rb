class QueueUpdatesJob < ActiveJob::Base
  queue_as :default

  def perform(class_name, *args)
    class_ = class_name.to_s.classify.constantize
    
    class_.find_in_batches(batch_size: 25) do |things|
      things.each do |thing|
        LodestoneUpdateJob.perform_later(thing, *args)
      end
    end
  end
end
