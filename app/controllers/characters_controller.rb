require 'securerandom'
require 'open-uri'

class CharactersController < ApplicationController
  before_action :authenticate_user!, :except => :show
  load_and_authorize_resource :find_by => :lodestone_id
  
  def import
    ensure_token
  end
  
  def redirect_to_verify
    redirect_to characters_import_path unless params.include? :lodestone_id
    redirect_to characters_verify_path(:lodestone_id => params[:lodestone_id])
  end
  
  def verify
    @character = Character.find_by_lodestone_id(params[:lodestone_id])
    return redirect_to @character if @character
    
    ensure_token
    
    @character = Character.new
    @character.user = current_user
    @character.lodestone_id = params[:lodestone_id]
    @character.lodestone_update
    
    valid = @character.bio.include? @token
    puts "Token: #{@token}, Bio: #{@character.bio}, Valid: #{valid}"
    
    if true#valid
      @character.save
      return redirect_to @character
    else
      session[:char_verify_data] = {
        'first_name' => @character.first_name, 'last_name' => @character.last_name,
        'world' => @character.world, 'bio' => @character.bio,
      }
      return redirect_to characters_unverified_path(:lodestone_id => @character.lodestone_id)
    end
  rescue OpenURI::HTTPError => error
    code = error.io.status[0].to_i
    if code == 404
      render 'lodestone_not_found'
    else
      render 'lodestone_error'
    end
  end
  
  def unverified
    redirect_to characters_verify_path(params[:lodestone_id]) unless session.include? :char_verify_data
    
    ensure_token
    @data = session[:char_verify_data]
    @link = lodestone_link(params[:lodestone_id])
  end
  
  def show
  end
  
  protected
  def ensure_token
    session[:char_verify_token] = SecureRandom.hex unless session.include? :char_verify_token
    @token = session[:char_verify_token]
  end
  
  def lodestone_link(lodestone_id=nil)
    lodestone_id = params[:lodestone_id] unless lodestone_id
    "http://na.finalfantasyxiv.com/lodestone/character/#{lodestone_id}/"
  end
end
