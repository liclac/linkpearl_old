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
    end
  end
end
