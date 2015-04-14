class UpdateCharacterAchievementsJob < ActiveJob::Base
  queue_as :default

  def perform(character)
    character.lodestone_achievements_update
    character.save!
  end
end
