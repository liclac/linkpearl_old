module API
  module V1
    class Characters < Grape::API
      version 'v1'
      
      helpers do
        def get_character(id)
          Character.where('id = ? or lodestone_id = ?', id, id).take!
        end
      end
      
      resource :characters do
        desc "Return list of characters"
        get do
          Character.all
        end
        
        desc "Returns a specific character"
        get ':id' do
          get_character(params[:id])
        end
      end
    end
  end
end
