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
      
      expose :synced_at, documentation: {
        type: DateTime, required: true, defaultValue: Time.current.utc,
        desc: "Time of the last lodestone sync"
      }
      
      expose :classes, documentation: {
        type: Hash, required: true, defaultValue: {
          'GLA' => { level: 10, exp: 1337, exp_next: 10000 },
          'ROG' => { level: 0, exp: 0, exp_next: 0 },
        },
        desc: "A hash of all classes, and the character's level"
      }
      
      def self.entity_name() "Character" end
      
      private
      def classes
        object.info['classes']
      end
    end
  end
end
