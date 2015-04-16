require 'test_helper'

class CharacterTest < ActiveSupport::TestCase
  test "lodestone update" do
    VCR.use_cassette 'lodestone_emi' do
      c = characters(:emi)
      c.lodestone_update
      assert_equal c.first_name, "Emi"
      assert_equal c.last_name, "Katapow"
      assert_equal c.bio, "25d0d67f057d46bdd4aea15bf16d4afa"
    end
  end
  
  test "lodestone update achievements" do
    VCR.use_cassette 'lodestone_emi' do
      c = characters(:emi)
      c.lodestone_update 'achievements'
      assert_equal c.achievements.length, 244
      
      a = Achievement.find_by_name! "Green Eyes"
      assert c.achievements.exists? a.id
    end
  end
  
  test "achievements are private" do
    VCR.use_cassette 'lodestone_yoshi' do
      c = characters(:yoshi)
      assert_raises LodestoneError do
        c.lodestone_update 'achievements'
      end
    end
  end
end
