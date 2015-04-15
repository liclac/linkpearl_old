module API
  module Entities
    class Achievement < Grape::Entity
      expose :id, documentation: {
        type: Integer, required: true, defaultValue: 0,
        desc: "Unique ID"
      }
      expose :lodestone_id, documentation: {
        type: Integer, required: true, defaultValue: 597,
        desc: "Lodestone ID"
      }
      
      expose :name, documentation: {
        type: String, required: true, defaultValue: "Green Eyes",
        desc: "Name of the achievement"
      }
      expose :description, documentation: {
        type: String, required: false,
        defaultValue: "Obtain the Veil of Wiyu in the quest \"A Relic Reborn.\"",
        desc: "Description and conditions for obtaining"
      }
      
      def self.entity_name() "Achievement" end
    end
  end
end
