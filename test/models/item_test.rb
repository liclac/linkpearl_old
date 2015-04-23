require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  test "a unique weapon" do
    VCR.use_cassette 'items/aiw_sword' do
      i = Item.new lodestone_id: '695c329d011'
      i.lodestone_update
      
      assert_equal "Arms", i.category.parent.name
      assert_equal "Gladiator's Arm", i.category.name
      assert_equal "Physical Damage", i.category.attr1
      assert_equal "Auto-attack", i.category.attr2
      assert_equal "Delay", i.category.attr3
      
      assert_equal "Augmented Ironworks Magitek Sword", i.name
      assert_nil i.description
      
      assert i.unique
      assert i.untradable
      
      assert_equal 130, i.ilvl
      assert_equal 'GLA PLD', i.classes
      assert_equal 50, i.level
      
      assert_equal 57, i.attr1
      assert_equal 38.00, i.attr2
      assert_equal 2.00, i.attr3
      
      assert_equal [
        ['Strength', 38], ['Vitality', 45],
        ['Accuracy', 25], ['Determination', 26],
      ], i.stats
    end
  end
  
  test "a normal shield" do
    VCR.use_cassette 'items/wootz_shield' do
      i = Item.new lodestone_id: 'a0998dadcc1'
      i.lodestone_update
      
      assert_equal "Armor", i.category.parent.name
      assert_equal "Shield", i.category.name
      assert_equal "Block Strength", i.category.attr1
      assert_equal "Block Rate", i.category.attr2
      assert_nil i.category.attr3
      
      assert_equal "Wootz Shield", i.name
      assert_nil i.description
      
      assert_not i.unique
      assert_not i.untradable
      
      assert_equal 110, i.ilvl
      assert_equal 'GLA PLD', i.classes
      assert_equal 50, i.level
      
      assert_equal 255, i.attr1
      assert_equal 103, i.attr2
      assert_nil i.attr3
      
      assert_equal [
        ['Strength', 11], ['Vitality', 11],
        ['Critical Hit Rate', 10], ['Skill Speed', 7],
      ], i.stats
    end
  end
  
  test "a token item" do
    VCR.use_cassette 'items/cs_atma' do
      i = Item.new lodestone_id: '16cbb02efd1'
      i.lodestone_update
      
      assert_equal "Atma of the Maiden", i.name
      assert_equal "The crystallized essence of the fallen, won from a battle in the Central Shroud.", i.description
    end
  end
end
