class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :cookie_authentication
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
    if session[:user_id]
      @current_user = User.find session[:user_id]
    else
      redirect_to login_path
    end
  end
  
  private
  
  def cookie_authentication
    if params[:username] 
      if u = User.where(:name => params[:username]).first
        if u.id == session[:user_id]
          return
        elsif r = cookies.signed[:remember]
          if r.first == u.id && r.second == u.secret
            session[:user_id] = u.id
            return
          end
        end
      end
      redirect_to login_path
    end
  end
  
end
