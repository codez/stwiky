class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :cookie_authentication
  before_filter :set_current_user
  
  protected
  
  def set_current_user
    if session[:user_id]
      @current_user = User.find session[:user_id]
    else
      redirect_to login_path
    end
  end
  
  private
  
  def cookie_authentication
    unless session[:user_id]
      if r = cookies.signed[:remember]
        if u = User.where(:id => r.first, :secret => r.second, :logged_in => true).first
          session[:user_id] = u.id
        end
      end
    end
  end
  
end
