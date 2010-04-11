# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def protect
    if session[:user_id].nil?
      redirect_to :action => 'login', :controller => 'Sessions'
      return false
    end
  end
  
  def current_user
    @user ||= User.find_by_id( session[:user_id] )
  end
  
end
