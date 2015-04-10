module API
  module V1
    class Groups < Grape::API
      version 'v1'
      
      helpers do
        params :group_params do
          requires :name, type: String
          optional :message, type: String
        end
      end
      
      resource :groups do
        desc "Returns all accessible groups" do
          success API::Entities::Group
          failure [
            [401, "Missing authentication"],
          ]
        end
        oauth2
        get do
          present current_user.groups, with: API::Entities::Group
        end
        
        desc "Creates a new group" do
          success API::Entities::Group
          failure [
            [401, "Missing authentication"],
            [403, "The founding character is not yours"],
          ]
        end
        params do
          use :group_params
          requires :founder_id, type: Integer, desc: "ID of the founding character"
        end
        oauth2
        post do
          authorize! :create, Group
          
          @founder = Character.find(params.founder_id)
          error!({error: "You can't found a group using somebody else's character!"}, 403) \
            unless @founder.user == current_user
          
          @group = Group.new
          @group.name = params.name
          @group.message = params.message
          @group.characters = [@founder]
          @group.save
          present @group, with: API::Entities::Group
        end
        
        desc "Returns a specific group" do
          success API::Entities::Group
          failure [
            [404, "The group does not exist"],
            [401, "Missing authentication"],
            [403, "Not allowed to access this group"],
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
            [404, "The group does not exist"],
            [401, "Missing authentication"],
            [403, "Not allowed to access this group"],
          ]
        end
        params do
          requires :id, type: Integer
          use :group_params
        end
        oauth2
        put ':id' do
          @group = Group.find(params[:id])
          @group.update(declared(params))
          authorize! :write, @group
          present @group, with: API::Entities::Group
        end
      end
    end
  end
end
