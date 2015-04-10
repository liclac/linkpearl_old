module API
  module Entities
    class Group < Grape::Entity
      expose :id, documentation: {
        type: Integer, required: true,
        desc: "Unique ID"
      }
      
      expose :name, documentation: {
        type: String, required: true, defaultValue: "Naul Chasers",
        desc: "The name of the group"
      }
      expose :message, documentation: {
        type: String, defaultValue: "Lorem ipsum dolor sit amet",
        desc: "A message only members can see"
      }
      
      expose :created_at, documentation: {
        type: DateTime, required: true, defaultValue: Time.current.utc,
        desc: "Time of the last edit"
      }
      expose :updated_at, documentation: {
        type: DateTime, required: true, defaultValue: Time.current.utc,
        desc: "Time of the group's creation"
      }
      
      expose :characters, using: API::Entities::Character, documentation: {
        is_array: true,
        desc: "Characters in this group"
      }
      
      def self.entity_name() "Group" end
    end
  end
end
