class UsersController < ApplicationController
  
  skip_before_filter :set_current_user
  
  def welcome
  end
  
  def login
    if user = User.login(params[:name], params[:password])
      init_session(user)
    else
      flash.now[:alert] = "Could not log you in"
      render :action => 'welcome'
    end
  end
  
  def logout
    User.find(session[:user_id]).update_attribute(:logged_in, false) if session[:user_id]
    session.clear
    cookies.delete :remember
    redirect_to({ :action => 'welcome'}, :notice => "You have been logged out")
  end
  
  def signup
    @user = User.new
  end
  
  def create
    @user = User.new params[:user]
    if @user.save
      init_session(@user)
    else
      render :action => 'signup'
    end
  end
  
  private
  
  def init_session(user)
      user.update_attribute :logged_in, true
      session[:user_id] = user.id
      cookies.signed[:remember] = {:value => [user.id, user.secret], :expires => 1.months.from_now } 
      redirect_to '/'   
  end
  
end