module API
  module V1
    class Groups < Grape::API
      version 'v1'
      
      helpers do
        params :group_params do
          optional :name, type: String
          optional :message, type: String
        end
      end
      
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
          requires :id, type: Integer
        end
        oauth2
        get ':id' do
          @group = Group.find(params[:id])
          authorize! :read, @group
          present @group, with: API::Entities::Group
        end
        
        desc "Updates group information" do
          success API::Entities::Group
          failure [
            [404, "The group does not exist", API::Entities::Error],
            [401, "Missing authentication", API::Entities::Error],
            [403, "Not allowed to access this group", API::Entities::Error],
          ]
        end
        params do
          requires :id, type: Integer
          use :group_params
        end
        oauth2
        put ':id' do
          puts params
          @group = Group.find(params[:id])
          @group.update(declared(params, include_missing: false))
          authorize! :write, @group
          present @group, with: API::Entities::Group
        end
      end
    end
  end
end
