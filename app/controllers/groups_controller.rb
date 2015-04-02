class GroupsController < ApplicationController
  before_action :authenticate_user!, :except => :show
  
  def new
  end
  
  def create
    @founder = Character.find(params[:founder])
    head :forbidden unless @founder and @founder.user == current_user
    
    @group = Group.new(group_params)
    @group.characters = [@founder]
    @group.save
    
    redirect_to @group
  end
  
  def show
    @group = Group.find(params[:id])
  end
  
  private
  def group_params
    params.require(:group).permit(:name, :message)
  end
end
