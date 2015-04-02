class GroupsController < ApplicationController
  before_action :authenticate_user!, :except => :show
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
    @character = Character.find_by_lodestone_id(params[:lodestone_id])
    return head(:forbidden) unless @character.user == current_user
    
    @group.characters.push @character
    redirect_to @group
  end
  
  def remove
    @character = Character.find_by_lodestone_id(params[:lodestone_id])
    return head(:forbidden) unless @character.user == current_user
    
    @group.characters.destroy @character
    redirect_to @group
  end
  
  private
  def group_params
    params.require(:group).permit(:name, :message)
  end
end
