class SignupsController < UsersController

  def show
    @user = User.new
  end
  
  def create
    @user = User.new params[:user]
    if answer_correct? && @user.save
      init_session(@user)
    else
      render :action => 'show'
    end
  end
  
  private 
  
  def answer_correct?
    correct = params[:answer].to_i == 42 || params[:answer].to_s =~ /forty.?two/i
    @user.errors.add(:base, "This is not the correct answer to life, the universe and Stwiky!") unless correct
    correct
  end
  
end