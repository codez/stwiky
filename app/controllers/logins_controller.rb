class LoginsController < UsersController
  
  def show
  end
  
  def create
    if user = User.login(params[:name], params[:password])
      init_session(user)
    else
      flash.now[:alert] = "Could not log you in"
      render :action => 'show'
    end
  end
  
  def destroy
    User.find(session[:user_id]).update_attribute(:logged_in, false) if session[:user_id]
    session.clear
    cookies.delete :remember
    redirect_to login_path, :notice => "You have been logged out"
  end
  
end