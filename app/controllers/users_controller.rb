class UsersController < ApplicationController
  
  abstract!
  
  skip_before_filter :set_current_user
  
  protected
  
  def init_session(user)
      session[:user_id] = user.id
      cookies.signed[:remember] = {:value => [user.id, user.secret], 
                                   :expires => 1.months.from_now,
                                   :path => notes_path(:username => user.name) } 
      redirect_to notes_path(:username => user.name)   
  end
  
end