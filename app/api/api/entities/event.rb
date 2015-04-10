module API
  module Entities
    class Event < Grape::Entity
      format_with(:time_only) { |dt| dt.strftime("%H:%M") }
      
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
      with_options(format_with: :time_only) do
        expose :time, documentation: {
          type: Time, required: true,
          desc: "Time of the event"
        }
      end
      
      def self.entity_name() "Event" end
    end
  end
end
