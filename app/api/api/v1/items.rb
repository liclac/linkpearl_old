module API
  module V1
    class Items < Grape::API
      version 'v1'
      
      helpers do
        def get_item(id)
          
          Item.where('id = ? or lodestone_id = ?', id.to_i, id).take or \
            error!({ :error => "Couldn't find Item with 'id'=#{id} or 'lodestone_id'=#{id}" }, 404)
        end
      end
      
      resource :items do
        desc "Returns all matching items" do
          success API::Entities::Item
        end
        params do
          requires :q, type: String, desc: "Search query"
        end
        get do
          @items = Item.search(params[:q]).records.all
          present @items, with: API::Entities::Item
        end
        
        desc "Returns a single item" do
          success API::Entities::Item
          failure [
            [404, "The item does not exist", API::Entities::Error],
          ]
        end
        params do
          requires :id, type: String, desc: "ID or Lodestone ID"
        end
        get ':id' do
          @item = get_item params[:id]
          present @item, with: API::Entities::Item
        end
      end
    end
  end
end