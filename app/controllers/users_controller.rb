class UsersController < ApplicationController
  def gallery
    reset_page
    @user = User.find_by_name(params[:user_id])
    @images = paginate @user.images, 20
    log_action("users_gallery")
  end
  
  def index
    reset_page
    @users = paginate(User.all.sort_by(&:last_visit))
    log_action("users_index")
  end
  
  def show
    reset_page
    Post.delete_expired
    Post.repopulate
    @user = User.find_by_name(params[:id])
    if @user
      @post = Post.new
      @pictures = @post.pictures.build
      @all_items = @user.posts
      @items = paginate @user.posts
      # images for photo gallery
      @images = @user.images.last 6
      log_action("users_show", @user.id, nil, @user.class.to_s)
      @user_shown = true
      save_search @user
    else
      flash[:error] = translate("User could not be found.")
      log_action("users_show_fail")
      redirect_to :back
    end
  end
  
  def new
    @user = User.new
    log_action("users_new")
  end
  
  def create
    @user = User.new(params[:user].permit(:name, :zip_code, :password))
    @user.ip = request.remote_ip.to_s
    @user.network_size = 100
    
    if @user.save
      @user = User.last
      log_action("users_create", @user.id)
      cookies.permanent[:auth_token] = @user.auth_token
      @user.update zip_code: Activity.last.zip_code if @user.zip_code.nil? \
        and Activity.last.zip_code.present?
      Zip.record(@user.zip_code) # logs zip if its unique
      
      if request.host.to_s.include? "elhero.com"
        @user.update english: true
      elsif request.host.to_s.include? "elheroe.net"
        @user.update english: false
      end
      
      redirect_to root_url
    else
      if @user.errors.include? :non_numeric_zip
        flash[:error] = @user.errors[:non_numeric_zip].first
      else
        flash[:error] = translate("Invalid input")
      end
      log_action("users_create_fail")
      redirect_to :back
    end
  end
  
  def edit
    @user_edit = true
    @user = User.find_by_name(params[:id])
    # for uploading a custom loading_gif
    @loading_gif = LoadingGif.new
    log_action("users_edit", @user.id)
  end
  
  def update
    @user = User.find_by_name(params[:id])
    if (@user == current_user or privileged?) and \
      @user.update(params[:user].permit(:icon, :name, :email, :bio, :zip_code,
      :network_size, :business, :english, :admin, :writer, :password, :skipped_tour))
      if @user == current_user
        flash[:notice] = translate("Your account was successfully updated.")
      else
        flash[:notice] = translate("User account successfully updated.")
      end
      Zip.record(@user.zip_code) # logs new zip code if its unique
      log_action("users_update", @user.id)
      redirect_to user_path(@user.name)
    else
      flash[:error] = translate("User profile could not be updated.")
      log_action("users_update_fail", @user.id)
      redirect_to :back
    end
  end
  
  def destroy
    @user = User.find_by_name(params[:id])
    if (@user == current_user or privileged?) and @user.destroy
      flash[:notice] = translate("The user was successfully deleted.")
      log_action("users_destroy")
      redirect_to users_path
    else
      flash[:error] = translate("The user could not be deleted.")
      log_action("users_destroy_fail")
      redirect_to :back
    end
  end
end
