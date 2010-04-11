# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def logged_in?
    not session[:user_id].nil?
  end
  
  def logged_in_user_is(user)
    session[:user_id] == user.id
  end
  
  def profile_link(user)
    user_url(user)
  end
  
  def paginated?
    @pages and @pages.length > 1
  end
  
end
