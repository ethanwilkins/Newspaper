class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user].permit(:name, :zip_code, :password))
    @user.network_size = 100
    @user.ip = request.remote_ip.to_s
    
    if @user.save
      user = User.last # need to change this eventually
      session[:user_id] = user.id # could log into user created at the same time
      # UserMailer.welcome_user(user).deliver
      redirect_to root_url
    else
      flash[:error] = translate("Invalid input")
      redirect_to :back
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update(params[:user].permit(:icon, :name, :email, :bio, :zip_code, :network_size, :business, :english))
      flash[:notice] = translate("Your account was successfully updated.")
      redirect_to @user
    else
      flash[:error] = translate("User profile could not be updated.")
      redirect_to :back
    end
  end
end
