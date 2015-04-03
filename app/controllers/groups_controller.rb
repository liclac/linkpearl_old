class GroupsController < ApplicationController
  before_action :authenticate_user!, :except => :show
  before_action :set_character, :only => [:add, :remove]
  load_and_authorize_resource
  
  def new
  end
  
  def create
    @founder = Character.find_by_lodestone_id(params[:founder])
    head :forbidden unless @founder and @founder.user == current_user
    
    @group = Group.new(group_params)
    @group.characters = [@founder]
    @group.save
    
    redirect_to @group
  end
  
  def edit
  end
  
  def update
    if @group.update(group_params)
      redirect_to @group
    else
      render 'edit'
    end
  end
  
  def show
  end
  
  def add
    @group.characters.push @character unless @group.characters.exists? @character
    redirect_to @group
  end
  
  def remove
    @group.characters.destroy @character
    redirect_to @group
  end
  
  private
  def set_character
    @character = Character.find_by_lodestone_id!(params[:lodestone_id])
  end
  
  def group_params
    params.require(:group).permit(:name, :message)
  end
end
