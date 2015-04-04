class EventsController < ApplicationController
  before_action :authenticate_user!, :except => :show
  before_action :set_group
  load_and_authorize_resource
  
  def new
  end
  
  def create
    @event.group = @group
    @event.save
    redirect_to @group
  end
  
  private
  def set_group
    @group = Group.find(params[:id])
  end
  
  def event_params
    params.require(:event).permit(:name, :time)
  end
end
