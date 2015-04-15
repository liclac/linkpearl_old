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
    end
  end
end