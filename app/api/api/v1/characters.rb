module API
  module V1
    class Characters < Grape::API
      version 'v1'
      
      helpers do
        def get_character(id)
          Character.where('id = ? or lodestone_id = ?', id, id).take or \
            error!({ :error => "Couldn't find Character with 'id'=#{id} or 'lodestone_id'=#{id}" }, 404)
        end
      end
      
      resource :characters do
        desc "Return list of characters" do
          success API::Entities::Character
        end
        params do
          optional :q, type: String, desc: "Optional search query (name)"
        end
        get do
          characters = []
          q = params[:q]
          if q
            parts = q.split(' ')
            case parts.length
            when 1
              characters = Character.where('lower(first_name) LIKE :q or lower(last_name) LIKE :q', { q: "%#{q}%".downcase }).all
            when 2
              characters = Character.where('lower(first_name) LIKE ? and lower(last_name) LIKE ?', "%#{parts[0]}%".downcase, "%#{parts[1]}%").all
            end
          else
            characters = Character.all
          end
          present characters, with: API::Entities::Character
        end
        
        desc "Returns a specific character" do
          success API::Entities::Character
          failure [
            [404, "The character does not exist", API::Entities::Error],
          ]
        end
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
