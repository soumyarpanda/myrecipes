class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # We want the ability to retrieve the current user
  # One user should not be able to edit other recipes
  
  helper_method :current_user, :logged_in?
  
  
  def current_user
    # if that last part exists then return the user
    # this is called memoization
    # Instead of hitting the DB again and again, it will check for user here and save request numbers
    @current_user ||= Chef.find(session[:chef_id]) if session[:chef_id]
  end
  
  def logged_in?
    # If user making request is logged in or not
    !!current_user
  end
  
  # If user is not logged in we want to send a message please Log In and redirect him/her  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform this action"
      redirect_to :back
    end
  end

end
