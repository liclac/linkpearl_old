class API::V1::CharactersController < ApplicationController
  before_action :authenticate_user!, :except => :show
  load_and_authorize_resource :find_by => :lodestone_id
  respond_to :json, :xml
  
  def show
    respond_with @character
  end
  
  def delete
    @character.destroy
    respond_with @character
  end
end
