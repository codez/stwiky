class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_current_user
  
  protected
  
  def rescue_action_in_public(exception)
    case exception
      when ::ActionController::RoutingError, ActiveRecord::RecordNotFound, ::ActionController::UnknownAction, ::ActionController::InvalidAuthenticityToken
        render(:file => "#{RAILS_ROOT}/public/404.html",
               :status => 404)
      else
        render(:file => "#{RAILS_ROOT}/public/500.html",
               :status => 500)
        SystemNotifier.deliver_exception_notification(self, request, exception)
    end                    
  end
  
  def set_current_user
    return if user_path?
    if session[:user_id]
      @current_user = User.find session[:user_id]
    else
      redirect_to login_path
    end
  end
  
  private
  
  def user_path?
    if params[:username]
      redirect_to login_path unless auto_login?
      true
    end
  end
  
  def auto_login?
    if @current_user = User.where(:name => params[:username]).first
      if @current_user.id == session[:user_id] ||
         @current_user.password.empty? ||
         remember_cookie?
        session[:user_id] = @current_user.id
        true
      end
    end
  end
  
  def remember_cookie?
    if r = cookies.signed[:remember]
      r.first == @current_user.id && r.second == @current_user.secret 
    else
      false
    end
  end
  
end
