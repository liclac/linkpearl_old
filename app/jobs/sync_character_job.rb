class SyncCharacterJob < ActiveJob::Base
  queue_as :default

  def perform(character_id)
    character = Character.find(character_id)
    character.lodestone_update
    character.save!
  end
end
