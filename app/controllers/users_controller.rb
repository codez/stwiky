class UsersController < ApplicationController
  
  skip_before_filter :set_current_user
  
  def welcome
  end
  
  def login
    if user = User.login(params[:name], params[:password])
      session[:user_id] = user.id
      redirect_to notes_url
    else
      flash.now[:alert] = "Could not log in"
      render :action => 'welcome'
    end
  end
  
  def logout
    session.clear
    redirect_to :action => 'welcome', :notice => "You have been logged out"
  end
  
  def signup
    @user = User.new
  end
  
  def create
    @user = User.new params[:user]
    if @user.save
      session[:user_id] = @user.id
      redirect_to notes_url
    else
      render :action => 'signup'
    end
  end
  
end