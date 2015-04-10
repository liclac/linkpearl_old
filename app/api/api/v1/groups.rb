module API
  module V1
    class Groups < Grape::API
      version 'v1'
      
      resource :groups do
        desc "Returns all accessible groups" do
          success API::Entities::Group
          failure [
            [401, "Missing authentication", API::Entities::Error],
          ]
        end
        oauth2
        get do
          present current_user.groups, with: API::Entities::Group
        end
        
        desc "Returns a specific group" do
          success API::Entities::Group
          failure [
            [404, "The group does not exist", API::Entities::Error],
            [401, "Missing authentication", API::Entities::Error],
            [403, "Not allowed to access this group", API::Entities::Error],
          ]
        end
        params do
          requires :id, type: Integer, desc: "ID of the group"
        end
        oauth2
        get ':id' do
          @group = Group.find(params[:id])
          authorize! :read, @group
          present @group, with: API::Entities::Group
        end
      end
    end
  end
end
