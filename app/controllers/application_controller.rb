class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_current_user
  
  protected
  
  def set_current_user
    if session[:user_id]
      @current_user = User.find session[:user_id]
    else
      redirect_to user_path
    end
  end
  
end
