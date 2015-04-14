class UpdateAchievementJob < ActiveJob::Base
  queue_as :default

  def perform(achievement, character_lodestone_id)
    achievement.lodestone_update(character_lodestone_id)
    achievement.save!
  end
end
