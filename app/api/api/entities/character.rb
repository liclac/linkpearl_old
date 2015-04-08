module API
  module Entities
    class Character < Grape::Entity
      expose :id
      expose :lodestone_id
      expose :user_id
      
      expose :first_name
      expose :last_name
      expose :world
      expose :bio
      
      expose :created_at
      expose :updated_at
    end
  end
end
