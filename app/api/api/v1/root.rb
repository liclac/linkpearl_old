module API
  module V1
    class Root < Grape::API
      helpers do
        def current_user
          resource_owner
        end
      end
      
      mount API::V1::Characters
      mount API::V1::Groups
      mount API::V1::Users
      mount API::V1::Items
    end
  end
end
