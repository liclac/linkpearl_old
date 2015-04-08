module API
  module V1
    class Characters < Grape::API
      version 'v1'
      format :json

      resource :characters do
        desc "Return list of characters"
        get do
          Character.all
        end
      end
    end
  end
end
