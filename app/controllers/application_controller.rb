class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    # Return current_user if current_user exists but if no current_user, 
    # find the user based on the user id set in the session.
    
  end
  
  def logged_in?
    !!current_user
    # This returns true if we have a current user and, if not, it will return
    # false.
    
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
    # If user not logged in it will display above error message and redirect
    # user to the root path.  If they are logged in this will NOT take place.
  end

end
