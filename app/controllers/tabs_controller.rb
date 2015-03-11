class TabsController < ApplicationController
  def pending
    @tabs = Tab.pending.reverse
    @subtabs = Subtab.pending.reverse
    log_action("tabs_pending")
  end
  
  def approve
    @tab = Tab.find(params[:id])
    if @tab.update approved: true
      Note.notify(current_user, User.find(@tab.user_id), :tab_approved, @tab.id)
      log_action("tabs_approve", @tab.id)
      flash[:notice] = translate("Tab successfully approved.")
    else
      flash[:error] = translate("Tab could not be approved.")
    end
    redirect_to :back
  end

  def deny
    @tab = Tab.find(params[:id])
    if @tab.update approved: false
      Note.notify(current_user, User.find(@tab.user_id), :tab_denied, @tab.id)
      log_action("tabs_deny", @tab.id)
      flash[:notice] = translate("The tab was successfully denied.")
    else
      flash[:error] = translate("The tab could not be denied.")
    end
    redirect_to :back
  end
  
  def show
    reset_page
    Post.delete_expired
    Post.repopulate
    @tab = Tab.find_by_id(params[:id])
    if @tab
      @tab_shown = true
      @subtabs = @tab.popular_subtabs
      @post = Post.new
      @pictures = @post.pictures.build
      build_tab_feed_data(@tab)
      save_search @tab
      log_action("tabs_show", @tab.id)
    else
      flash[:error] = translate("Tab could not be found.")
      redirect_to :back
    end
  end
  
  def new
    @tab = Tab.new
    log_action("tabs_new")
  end
  
  def create
    @tab = Tab.new(params[:tab].permit(:icon, :name, :description, :company,
      :sponsored, :sponsored_only, :translation_requested))
    @tab.approved = true if current_user.admin
    @tab.user_id = current_user.id
    
    unless current_user.global
      @tab.zip_code = current_user.zip_code
      @tab.ip = request.remote_ip.to_s
      @tab.latitude = current_user.latitude
      @tab.longitude = current_user.longitude
    end
    
    if @tab.save
      if @tab.translation_requested
        if current_user.english
          @tab.translations.create(request: true, english: @tab.name,
            field: "name", user_id: current_user.id)
          @tab.translations.create(request: true, english: @tab.description,
            field: "description", user_id: current_user.id)
        else
          @tab.translations.create(request: true, spanish: @tab.name,
            field: "name", user_id: current_user.id)
          @tab.translations.create(request: true, spanish: @tab.description,
            field: "description", user_id: current_user.id)
        end
      end
      
      flash[:notice] = translate "Your tab was successfully submitted."
      log_action("tabs_create", @tab.id)
      redirect_to tabs_path
    else
      flash[:error] = translate "Invalid input"
      log_action("tabs_create_fail")
      redirect_to :back
    end
  end
  
  def update
    @tab = Tab.find(params[:id])
    if @tab.update(params[:tab].permit(:icon, :name, :description, :company, :sponsored,
      :sponsored_only, :english_name, :english_description, :translation_requested, :zip_code))
      @tab.add_hashtags(params[:hashtags])
      flash[:notice] = translate("Tab updated successfully.")
      redirect_to @tab
    else
      flash[:error] = translate("Invalid input.")
      redirect_to :back
    end
  end
  
  def destroy
    @tab = Tab.find(params[:id])
    if @tab.destroy
      flash[:notice] = translate("Tab deleted successfully.")
      log_action("tabs_destroy")
      redirect_to tabs_path
    else
      flash[:error] = translate "There was a problem deleting the tab."
      redirect_to :back
    end
  end
  
  def edit
    @tab = Tab.find(params[:id])
    # for uploading a custom loading_gif
    @loading_gif = LoadingGif.new
    @tab_edit = true
  end
  
  def index
    @tabs = Tab.approved.reverse
    log_action("tabs_index")
  end
end
