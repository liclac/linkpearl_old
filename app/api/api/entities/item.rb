module API
  module Entities
    class Item < Grape::Entity
      expose :id, documentation: {
        type: Integer, required: true, defaultValue: 0,
        desc: "Unique ID"
      }
      expose :lodestone_id, documentation: {
        type: String, required: true, defaultValue: "123456789ab",
        desc: "Lodestone ID"
      }
      
      expose :name, documentation: {
        type: String, required: true, defaultValue: "Fancy Thingy",
        desc: "Name of the item"
      }
      expose :description, documentation: {
        type: String, required: false, defaultValue: "Lorem ipsum dolor sit amet",
        desc: "Flavor text, if present"
      }
      
      expose :ilvl, documentation: {
        type: Integer, required: false, defaultValue: 130,
        desc: "Item Level"
      }
      expose :classes, documentation: {
        type: String, required: false, defaultValue: ["GLA", "PLD"],
        desc: "Classes allowed to equip this item"
      }
      expose :level, documentation: {
        type: Integer, required: false, defaultValue: 50,
        desc: "Level required to equip this item"
      }
      expose :attr1, documentation: {
        type: Integer, required: false, defaultValue: 69,
        desc: "Primary attribute (see category)"
      }
      expose :attr2, documentation: {
        type: Integer, required: false, defaultValue: 42,
        desc: "Secondary attribute (see category)"
      }
      expose :attr3, documentation: {
        type: Integer, required: false, defaultValue: 80,
        desc: "Thirtary attribute (see category)"
      }
      expose :stats, documentation: {
        type: Array, required: false, defaultValue: [['Strength', 49], ['Critical Hit Rate', 56]],
        desc: "The item's stat bonuses when equipped, in presentation order"
      }
      
      expose :unique, documentation: {
        type: 'boolean', required: true, defaultValue: false,
        desc: "Is this item Unique?"
      }
      expose :untradable, documentation: {
        type: 'boolean', required: true, defaultValue: false,
        desc: "Is this item Untradable?"
      }
      
      expose :category, using: API::Entities::ItemCategory, documentation: {
        required: true, desc: "This item's category"
      }
      
      expose :version, documentation: {
        type: String, required: true, defaultValue: "2.56",
        desc: "Version of the game this data corresponds to"
      }
      expose :synced_at, documentation: {
        type: DateTime, required: true, defaultValue: Time.current.utc,
        desc: "Time of the last lodestone sync"
      }
      
      def classes
        object.classes.try(:split, ' ')
      end
    end
  end
end
