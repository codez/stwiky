class UsersController < ApplicationController
  
  abstract!
  
  skip_before_filter :set_current_user
  
  protected
  
  def init_session(user)
      user.update_attribute :logged_in, true
      session[:user_id] = user.id
      cookies.signed[:remember] = {:value => [user.id, user.secret], :expires => 1.months.from_now } 
      redirect_to user_board_path(:user => user)   
  end
  
end