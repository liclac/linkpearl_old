module API
  module V1
    class Characters < Grape::API
      version 'v1'
      
      helpers do
        def get_character(id)
          Character.where('id = ? or lodestone_id = ?', id, id).take or \
            error! "No such character", 404
        end
      end
      
      resource :characters do
        desc "Return list of characters"
        get do
          present Character.all, with: API::Entities::Character
        end
        
        desc "Returns a specific character"
        params do
          requires :id, type: Integer, desc: "ID or Lodestone ID"
        end
        get ':id' do
          present get_character(params[:id]), with: API::Entities::Character
        end
      end
    end
  end
end
