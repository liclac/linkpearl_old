module API
  module Entities
    class Event < Grape::Entity
      format_with(:time_only) { |dt| "lol" }
      
      expose :id, documentation: {
        type: Integer, required: true,
        desc: "Unique ID"
      }
      expose :group_id, documentation: {
        type: Integer, required: true,
        desc: "ID of the associated group"
      }
      
      expose :name, documentation: {
        type: String, required: true, defaultValue: "gib naul",
        desc: "Name of the event"
      }
      expose :time, documentation: {
        type: Time, required: true,
        format_with: :time_only,
        desc: "Time of the event"
      }
      
      def self.entity_name() "Event" end
    end
  end
end
