class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    Activity.log_action(current_user, request.remote_ip.to_s, "users_show", @user.id)
  end
  
  def new
    @user = User.new
    Activity.log_action(current_user, request.remote_ip.to_s, "users_new")
  end
  
  def create
    @user = User.new(params[:user].permit(:name, :zip_code, :password))
    @user.ip = request.remote_ip.to_s
    @user.network_size = 100
    
    if @user.save
      user = User.last # need to change this eventually
      session[:user_id] = user.id # could log into user created at the same time
      Zip.record(@user.zip_code) # logs zip if its unique
      Activity.log_action(current_user, request.remote_ip.to_s, "users_create", @user.id)
      redirect_to root_url
    else
      flash[:error] = translate("Invalid input")
      Activity.log_action(current_user, request.remote_ip.to_s, "users_create_fail")
      redirect_to :back
    end
  end
  
  def edit
    @user = User.find(params[:id])
    Activity.log_action(current_user, request.remote_ip.to_s, "users_edit", @user.id)
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(params[:user].permit(:icon, :name, :email, :bio, :zip_code, :network_size, :business, :english))
      flash[:notice] = translate("Your account was successfully updated.")
      Zip.record(@user.zip_code) # logs new zip code if its unique
      Activity.log_action(current_user, request.remote_ip.to_s, "users_update", @user.id)
      redirect_to @user
    else
      flash[:error] = translate("User profile could not be updated.")
      Activity.log_action(current_user, request.remote_ip.to_s, "users_update_fail", @user.id)
      redirect_to :back
    end
  end
end
