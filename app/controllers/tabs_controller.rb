class TabsController < ApplicationController
  def pending
    @tabs = Tab.pending.reverse
    @subtabs = Subtab.pending.reverse
    Activity.log_action(current_user, request.remote_ip.to_s, "tabs_pending")
  end
  
  def approve
    @tab = Tab.find(params[:id])
    @tab.update approved: true
    Note.notify(current_user, User.find(@tab.user_id),
      :tab_approved, @tab.id)
    Activity.log_action(current_user, request.remote_ip.to_s, "tabs_approve", @tab.id)
    redirect_to :back
  end

  def deny
    @tab = Tab.find(params[:id])
    @tab.update approved: false
    Note.notify(current_user, User.find(@tab.user_id),
      :tab_denied, @tab.id)
    Activity.log_action(current_user, request.remote_ip.to_s, "tabs_deny", @tab.id)
    redirect_to :back
  end
  
  def new
    @tab = Tab.new
    Activity.log_action(current_user, request.remote_ip.to_s, "tabs_new")
  end
  
  def create
    @tab = Tab.new(params[:tab].permit(:icon, :name, :description, :company, :sponsored, :sponsored_only))
    @tab.approved = true if current_user.admin
    @tab.zip_code = current_user.zip_code
    @tab.ip = request.remote_ip.to_s
    @tab.user_id = current_user.id
    
    if @tab.save
      flash[:notice] = translate "Your tab was successfully submitted."
      Activity.log_action(current_user, request.remote_ip.to_s, "tabs_create", @tab.id)
      redirect_to tabs_path
    else
      flash[:error] = translate "Invalid input"
      Activity.log_action(current_user, request.remote_ip.to_s, "tabs_create_fail")
      redirect_to :back
    end
  end
  
  def destroy
    @tab = Tab.find(params[:id])
    if @tab.destroy
      Activity.log_action(current_user, request.remote_ip.to_s, "tabs_destroy")
      redirect_to tabs_path
    else
      flash[:error] = translate "There was a problem trying to delete the tab."
      redirect_to :back
    end
  end
  
  def index
    @tabs = Tab.approved.reverse
    Activity.log_action(current_user, request.remote_ip.to_s, "tabs_index")
  end
  
  def show
    @advert = Article.local_advert(current_user)
    @tab = Tab.find(params[:id])
    @subtabs = @tab.popular_subtabs
    @posts = @tab.posts.reverse
    @post = Post.new
    Activity.log_action(current_user, request.remote_ip.to_s, "tabs_show", @tab.id)
  end
end
