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
          authorize! :write, @group
          @group.update(declared(params))
          present @group, with: API::Entities::Group
        end
        
        desc "Deletes a group" do
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
        delete ':id' do
          @group = Group.find(params[:id])
          authorize! :delete, @group
          @group.destroy
          present @group, with: API::Entities::Group
        end
        
        desc "Returns all members in the group" do
          success API::Entities::Character
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
        get ':id/characters' do
          @group = Group.find(params[:id])
          authorize! :read, @group
          present @group.characters, with: API::Entities::Character
        end
        
        desc "Adds a member to a group" do
          success API::Entities::Character
          failure [
            [404, "The group or character does not exist"],
            [401, "Missing authentication"],
            [403, "Not allowed to access this group"],
            [409, "Attempted to re-add an existing member"],
          ]
        end
        params do
          requires :id, type: Integer, desc: "ID of the group"
          requires :character_id, type: Integer, desc: "ID of the character to add"
        end
        oauth2
        post ':id/characters' do
          @character = Character.find(params[:character_id])
          @group = Group.find(params[:id])
          authorize! :write, @group
          
          error!({error: "That character is already a member!"}, 409)\
            if @group.characters.exists? @character
          
          @group.characters.push @character
          status 201
          present @group.characters, with: API::Entities::Character
        end
        
        desc "Removes a member from a group" do
          success API::Entities::Character
          failure [
            [404, "The group does not exist"],
            [401, "Missing authentication"],
            [403, "Not allowed to access this group"],
            [410, "The character is not a member of the group"],
          ]
        end
        params do
          requires :id, type: Integer, desc: "ID of the group"
          requires :character_id, type: Integer, desc: "ID of the character to remove"
        end
        oauth2
        delete ':id/characters/:character_id' do
          @character = Character.find(params[:character_id])
          @group = Group.find(params[:id])
          authorize! :write, @group
          
          error!({error: "That character isn't a member!"}, 410)\
            unless @group.characters.exists? @character
          
          @group.characters.destroy @character
          present @group.characters, with: API::Entities::Character
        end
        
        desc "Returns all events for the group" do
          success API::Entities::Event
          failure [
            [404, "The group does not exist"],
            [401, "Missing authentication"],
            [403, "Not allowed to access this group"],
          ]
        end
        params do
          requires :id, type: Integer, desc: "ID of the group"
        end
        oauth2
        get ':id/events' do
          @group = Group.find(params[:id])
          authorize! :read, @group
          present @group.events, with: API::Entities::Event
        end
        
        desc "Creates a new event" do
          success API::Entities::Event
          failure [
            [404, "The group does not exist"],
            [401, "Missing authentication"],
            [403, "Not allowed to access this group"],
          ]
        end
        params do
          requires :id, type: Integer, desc: "ID of the group"
          requires :name, type: String, desc: "Name of the event"
          requires :time, type: String, desc: "When it goes down (UTC!)", regexp: /\d?\d:\d\d/
        end
        oauth2
        post ':id/events' do
          @group = Group.find(params[:id])
          authorize! :write, @group
          authorize! :create, Event
          
          @event = Event.create!({
            group: @group,
            name: params[:name], time: params[:time],
          })
          present @event, with: API::Entities::Event
        end
        
        desc "Deletes an event" do
          success API::Entities::Event
          failure [
            [404, "The group or event does not exist"],
            [401, "Missing authentication"],
            [403, "Not allowed to access this group"],
          ]
        end
        params do
          requires :id, type: Integer, desc: "ID of the group"
          requires :event_id, type: Integer, desc: "ID of the event"
        end
        oauth2
        delete ':id/events/:event_id' do
          @event = Event.find(params[:event_id])
          authorize! :delete, @event
          @event.destroy
          present @event, with: API::Entities::Event
        end
      end
    end
  end
end
