class ItemsController < ApplicationController
  skip_authorization_check
  
  def index
  end
  
  def show
    @item = Item.friendly.find params[:id]
  end
end
