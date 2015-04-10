module API
  module Entities
    class Group < Grape::Entity
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
      
      def self.entity_name() "Group" end
    end
  end
end
