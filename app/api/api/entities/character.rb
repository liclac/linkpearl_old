module API
  module Entities
    class Character < Grape::Entity
      expose :id, documentation: {
        type: Integer, required: true, defaultValue: 0,
        desc: "Unique ID"
      }
      expose :lodestone_id, documentation: {
        type: Integer, required: true, defaultValue: 7806252,
        desc: "Lodestone ID"
      }
      expose :user_id, documentation: {
        type: Integer, required: true,
        desc: "ID of the associated user"
      }
      
      expose :first_name, documentation: {
        type: String, required: true, defaultValue: "Yoshida",
        desc: "The character's first name"
      }
      expose :last_name, documentation: {
        type: String, required: true, defaultValue: "Eee",
        desc: "The character's last name"
      }
      expose :world, documentation: {
        type: String, required: true, defaultValue: "Chocobo",
        desc: "Name of the character's world"
      }
      expose :bio, documentation: {
        type: String, required: false, defaultValue: "Lorem ipsum dolor sit amet",
        desc: "Freeform character profile"
      }
      
      expose :created_at, documentation: {
        type: DateTime, required: true, defaultValue: Time.current.utc,
        desc: "Time of the last update"
      }
      expose :updated_at, documentation: {
        type: DateTime, required: true, defaultValue: Time.current.utc,
        desc: "Time of initial import"
      }
      
      def self.entity_name() "Character" end
    end
  end
end
