class EventsController < ApplicationController
  before_action :authenticate_user!, :except => :show
  load_and_authorize_resource
  
  def new
  end
  
  def create
    @group = Group.find(params[:id])
    @event.group = @group
    @event.save
    redirect_to @group
  end
  
  def edit
  end
  
  def update
    if @event.update(event_params)
      redirect_to @event.group
    else
      render 'edit'
    end
  end
  
  private
  def event_params
    params.require(:event).permit(:name, :time)
  end
end
