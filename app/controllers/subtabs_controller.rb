class SubtabsController < ApplicationController
  def approve
    @subtab = Subtab.find(params[:id])
    if @subtab.update approved: true
      Note.notify(current_user, User.find(@subtab.user_id),
        :subtab_approved, @subtab.id)
      flash[:notice] = translate "The subtab was successfully approved."
      Activity.log_action(current_user, request.remote_ip.to_s, "subtabs_approve", @subtab.id)
      redirect_to :back
    else
      flash[:error] = translate "The subtab could not be approved."
      Activity.log_action(current_user, request.remote_ip.to_s, "subtabs_approve_fail")
      redirect_to :back
    end
  end

  def deny
    @subtab = Subtab.find(params[:id])
    @subtab.update approved: false
    Note.notify(current_user, User.find(@subtab.user_id),
      :subtab_denied, @subtab.id)
    Activity.log_action(current_user, request.remote_ip.to_s, "subtabs_deny", @subtab.id)
    redirect_to :back
  end
  
  def new
    @subtab = Subtab.new
    Activity.log_action(current_user, request.remote_ip.to_s, "subtabs_new")
  end
  
  def create
    @subtab = Subtab.new(params[:subtab].permit(:icon, :name, :description, :english_name))
    @subtab.approved = true if current_user.admin
    @subtab.ip = request.remote_ip.to_s
    @subtab.user_id = current_user.id
    @subtab.tab_id = params[:tab_id]
    @post.latitude = current_user.latitude
    @post.longitude = current_user.longitude
    
    if @subtab.save
      flash[:notice] = translate "Your subtab was successfully submitted."
      Activity.log_action(current_user, request.remote_ip.to_s, "subtabs_create", @subtab.id)
      redirect_to tab_path(@subtab.tab_id)
    else
      flash[:error] = translate "Invalid input"
      Activity.log_action(current_user, request.remote_ip.to_s, "subtabs_create_fail")
      redirect_to :back
    end
  end
  
  def index
    @tab = Tab.find(params[:tab_id])
    @subtabs = @tab.subtabs.approved.reverse
    Activity.log_action(current_user, request.remote_ip.to_s, "subtabs_index")
  end
  
  def show
    Post.delete_expired
    Post.repopulate
    @advert = Article.local_advert(current_user)
    @subtab = Subtab.find(params[:id])
    @posts = @subtab.posts.reverse
    @post = Post.new
    Activity.log_action(current_user, request.remote_ip.to_s, "subtabs_show", @subtab.id)
  end
end
