class API::V1::CharactersController < ApplicationController
  before_action :authenticate_user!, :except => :show
  load_and_authorize_resource :find_by => :lodestone_id
  respond_to :json, :xml
  swagger_controller :characters, "Characters"
  
  def show
    respond_with @character
  end
  swagger_api :show do
    summary "Fetches a single Character"
    param :path, :id, :integer, :required, "The character's Lodestone ID"
    response :unauthorized
    response :not_found
  end
  
  def delete
    @character.destroy
    respond_with @character
  end
end
