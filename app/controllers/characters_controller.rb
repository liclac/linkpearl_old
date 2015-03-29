require 'securerandom'
require 'open-uri'

class CharactersController < ApplicationController
  def import
    ensure_token
  end
  
  def redirect_to_verify
    redirect_to characters_import_path unless params.include? :lodestone_id
    redirect_to characters_verify_path(:lodestone_id => params[:lodestone_id])
  end
  
  def verify
    ensure_token
    
    char = Character.new
    char.lodestone_id = params[:lodestone_id]
    char.lodestone_update
    
    valid = char.bio and char.bio.include? @token
    
    if valid
      char.save
      redirect_to char
    else
      session[:char_verify_data] = {
        'first_name' => char.first_name, 'last_name' => char.last_name,
        'world' => char.world, 'bio' => char.bio,
      }
      redirect_to characters_unverified_path(:lodestone_id => char.lodestone_id)
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
    @character = Character.find_by_lodestone_id(params[:id])
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
