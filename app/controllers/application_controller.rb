class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # Make sure users can only do things they're authorized to do
  check_authorization :unless => :unauthorizable_controller?
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
  
  private
  def unauthorizable_controller?
    self.devise_controller? or self.is_a? RailsAdmin::ApplicationController
  end
end
