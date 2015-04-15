module API
  module Entities
    class User < Grape::Entity
      expose :id, documentation: {
        type: Integer, required: true,
        desc: "Unique ID"
      }
      expose :email, documentation: {
        type: String, required: true,
        desc: "Sign-in email"
      }
      
      expose :characters, using: API::Entities::Character, documentation: {
        is_array: true,
        desc: "The user's characters"
      }
    end
  end
end