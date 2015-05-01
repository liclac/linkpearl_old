module API
  module Entities
    class ItemCategory < Grape::Entity
      expose :id, documentation: {
        type: Integer, required: true, defaultValue: 0,
        desc: "Unique ID"
      }
      expose :lodestone_id, documentation: {
        type: String, required: true, defaultValue: "1.85",
        desc: "Lodestone ID"
      }
      
      expose :name, documentation: {
        type: String, required: true, defaultValue: "Cool Stuff",
        desc: "Name of the category"
      }
      expose :attr1, documentation: {
        type: String, required: false, defaultValue: "Physical Damage",
        desc: "Items' primary attribute"
      }
      expose :attr2, documentation: {
        type: String, required: false, defaultValue: "Auto-attack",
        desc: "Items' secondary attribute"
      }
      expose :attr3, documentation: {
        type: String, required: false, defaultValue: "Delay",
        desc: "Items' thirtary attribute"
      }
      
      # TODO: Include this in the docs without causing an infinite loop
      expose :parent, using: API::Entities::ItemCategory
    end
  end
end
