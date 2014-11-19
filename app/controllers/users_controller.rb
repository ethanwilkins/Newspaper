class UsersController < ApplicationController
  def show
    Post.delete_expired
    Post.repopulate
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
      @user = User.last
      cookies.permanent[:auth_token] = @user.auth_token
      Activity.log_action(current_user, request.remote_ip.to_s, "users_create", @user.id)
      @user.update zip_code: Activity.last.zip_code if @user.zip_code.nil? and Activity.last.zip_code.present?
      Zip.record(@user.zip_code) # logs zip if its unique
      redirect_to root_url
    else
      if @user.errors.include? :non_numeric_zip
        flash[:error] = @user.errors[:non_numeric_zip].first
      else
        flash[:error] = translate("Invalid input")
      end
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
