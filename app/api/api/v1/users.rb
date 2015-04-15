module API
  module V1
    class Users < Grape::API
      version 'v1'
      
      resource :users do
        desc "Returns the authenticated user" do
          success API::Entities::User
          failure [
            [401, "Missing authentication"],
          ]
        end
        oauth2
        get 'me' do
          present current_user, with: API::Entities::User
        end
      end
    end
  end
end