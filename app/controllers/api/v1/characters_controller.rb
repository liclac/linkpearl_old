class API::V1::CharactersController < ApplicationController
  before_action :doorkeeper_authorize!, :except => :show
  before_filter :set_character, :except => [:index]
  load_and_authorize_resource
  respond_to :json, :xml
  swagger_controller :characters, "Characters"
  
  def index
    respond_with @characters
  end
  swagger_api :index do
    summary "Fetches all known Characters"
  end
  
  def show
    respond_with @character
  end
  swagger_api :show do
    summary "Fetches a single Character"
    param :path, :id, :integer, :required, "The character's ID or Lodestone ID"
    response :not_found
  end
  
  private
  def set_character
    @character = Character.where('id = ? or lodestone_id = ?', params[:id], params[:id]).take!
  end
end
