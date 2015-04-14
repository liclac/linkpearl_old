class UpdateCharacterJob < ActiveJob::Base
  queue_as :default

  def perform(character)
    character.lodestone_update
    character.synced_at = Time.now
    character.save!
  end
end
