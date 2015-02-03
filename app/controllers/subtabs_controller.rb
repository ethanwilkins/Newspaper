class SubtabsController < ApplicationController
  def approve
    @subtab = Subtab.find(params[:id])
    if @subtab.update approved: true
      Note.notify(current_user, User.find(@subtab.user_id),
        :subtab_approved, @subtab.id)
      flash[:notice] = translate "The subtab was successfully approved."
      log_action("subtabs_approve", @subtab.id)
      redirect_to :back
    else
      flash[:error] = translate "The subtab could not be approved."
      log_action("subtabs_approve_fail")
      redirect_to :back
    end
  end

  def deny
    @subtab = Subtab.find(params[:id])
    @subtab.update approved: false
    Note.notify(current_user, User.find(@subtab.user_id),
      :subtab_denied, @subtab.id)
    log_action("subtabs_deny", @subtab.id)
    redirect_to :back
  end
  
  def new
    @subtab = Subtab.new
    log_action("subtabs_new")
  end
  
  def create
    @subtab = Subtab.new(params[:subtab].permit(:icon, :name, :description, :english_name))
    @subtab.approved = true if current_user.admin
    @subtab.ip = request.remote_ip.to_s
    @subtab.user_id = current_user.id
    @subtab.tab_id = params[:tab_id]
    @subtab.latitude = current_user.latitude
    @subtab.longitude = current_user.longitude
    @subtab.zip_code = current_user.zip_code
    
    if @subtab.save
      flash[:notice] = translate "Your subtab was successfully submitted."
      log_action("subtabs_create", @subtab.id)
      redirect_to tab_path(@subtab.tab_id)
    else
      flash[:error] = translate "Invalid input"
      log_action("subtabs_create_fail")
      redirect_to :back
    end
  end
  
  def update
    @subtab = Subtab.find(params[:id])
    if @subtab.update(params[:subtab].permit(:icon, :name, :description, :company, :sponsored,
      :sponsored_only, :translation_requested, :zip_code))
      flash[:notice] = translate("Subtab updated successfully.")
      redirect_to @subtab
    else
      flash[:error] = translate("Invalid input.")
      redirect_to :back
    end
  end
  
  def destroy
    @subtab = Subtab.find(params[:id])
    @tab = @subtab.tab
    if @subtab.destroy
      flash[:notice] = translate("Tab deleted successfully.")
      log_action("tabs_destroy")
      redirect_to tab_path(@tab)
    else
      flash[:error] = translate "There was a problem deleting the tab."
      redirect_to :back
    end
  end
  
  def edit
    @subtab = Subtab.find(params[:id])
    # for uploading a custom loading_gif
    @loading_gif = LoadingGif.new
    @subtab_edit = true
  end
  
  def index
    @tab = Tab.find(params[:tab_id])
    @subtabs = @tab.subtabs.approved.reverse
    log_action("subtabs_index")
  end
  
  def show
    reset_page
    Post.delete_expired
    Post.repopulate
    @advert = Article.local_advert(current_user)
    @subtab = Subtab.find_by_id(params[:id])
    if @subtab
      @subtab_shown = true
      @posts = @subtab.posts.reverse
      @post = Post.new
      @pictures = @post.pictures.build
      build_tab_feed_data(@subtab)
      save_search @subtab
      log_action("subtabs_show", @subtab.id)
    else
      log_action("subtabs_show_fail")
    end
  end
end
