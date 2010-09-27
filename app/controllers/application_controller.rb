class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_current_user
  
  protected
  
  def set_current_user
    @current_user = User.find_by_name 'pascal'
  end
  
end
