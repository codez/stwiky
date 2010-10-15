class LoginsController < UsersController
  
  def show
  end
  
  def create
    if user = User.login(params[:username], params[:password])
      init_session(user)
    else
      flash.now[:alert] = "Could not log you in"
      render :action => 'show'
    end
  end
  
  def destroy
    if session[:user_id]
      user = User.find(session[:user_id])
      cookies.delete :remember, :path => user_board_path(:username => user.name)
    end
    session.clear
    redirect_to login_path, :notice => "You have been logged out"
  end
  
end