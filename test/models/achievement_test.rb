require 'test_helper'

class AchievementTest < ActiveSupport::TestCase
  test "lodestone update" do
    VCR.use_cassette 'lodestone_achievements' do
      c = characters(:emi)
      a = achievements(:green_eyes)
      a.lodestone_update c.lodestone_id
      assert_equal a.name, "Green Eyes"
      assert_equal a.description, "Obtain the Veil of Wiyu in the quest \"A Relic Reborn.\""
    end
  end
end
