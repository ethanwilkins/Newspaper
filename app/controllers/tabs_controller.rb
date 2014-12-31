class TabsController < ApplicationController
  def pending
    @tabs = Tab.pending.reverse
    @subtabs = Subtab.pending.reverse
    Activity.log_action(current_user, request.remote_ip.to_s, "tabs_pending")
  end
  
  def approve
    @tab = Tab.find(params[:id])
    if @tab.update approved: true
      Note.notify(current_user, User.find(@tab.user_id), :tab_approved, @tab.id)
      Activity.log_action(current_user, request.remote_ip.to_s, "tabs_approve", @tab.id)
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
      Activity.log_action(current_user, request.remote_ip.to_s, "tabs_deny", @tab.id)
      flash[:notice] = translate("The tab was successfully denied.")
    else
      flash[:error] = translate("The tab could not be denied.")
    end
    redirect_to :back
  end
  
  def new
    @tab = Tab.new
    Activity.log_action(current_user, request.remote_ip.to_s, "tabs_new")
  end
  
  def create
    @tab = Tab.new(params[:tab].permit(:icon, :name, :description, :company,
      :sponsored, :sponsored_only, :translation_requested))
    @tab.approved = true if current_user.admin
    @tab.zip_code = current_user.zip_code
    @tab.ip = request.remote_ip.to_s
    @tab.user_id = current_user.id
    @tab.latitude = current_user.latitude
    @tab.longitude = current_user.longitude
    
    if @tab.save
      if @tab.translation_requested
        if current_user.english
          @tab.translations.create(request: true, english: @tab.name, field: "name")
          @tab.translations.create(request: true, english: @tab.description, field: "description")
        else
          @tab.translations.create(request: true, spanish: @tab.name, field: "name")
          @tab.translations.create(request: true, spanish: @tab.description, field: "description")
        end
      end
      
      flash[:notice] = translate "Your tab was successfully submitted."
      Activity.log_action(current_user, request.remote_ip.to_s, "tabs_create", @tab.id)
      redirect_to tabs_path
    else
      flash[:error] = translate "Invalid input"
      Activity.log_action(current_user, request.remote_ip.to_s, "tabs_create_fail")
      redirect_to :back
    end
  end
  
  def update
    @tab = Tab.find(params[:id])
    if @tab.update(params[:tab].permit(:icon, :name, :description, :company, :sponsored,
      :sponsored_only, :english_name, :english_description, :translation_requested))
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
      Activity.log_action(current_user, request.remote_ip.to_s, "tabs_destroy")
      redirect_to tabs_path
    else
      flash[:error] = translate "There was a problem deleting the tab."
      redirect_to :back
    end
  end
  
  def edit
    @tab = Tab.find(params[:id])
  end
  
  def index
    @tabs = Tab.approved.reverse
    Activity.log_action(current_user, request.remote_ip.to_s, "tabs_index")
  end
  
  def show
    reset_page
    Post.delete_expired
    Post.repopulate
    @advert = Article.local_advert(current_user)
    @tab = Tab.find(params[:id])
    @subtabs = @tab.popular_subtabs
    @posts = paginate @tab.posts
    @post = Post.new
    Activity.log_action(current_user, request.remote_ip.to_s, "tabs_show", @tab.id)
  end
end
