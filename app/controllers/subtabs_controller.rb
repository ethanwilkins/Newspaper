class SubtabsController < ApplicationController
  def approve
    @subtab = Subtab.find(params[:id])
    if @subtab.update approved: true
      Note.notify(current_user, User.find(@subtab.user_id),
        :subtab_approved, @subtab.id)
      flash[:notice] = translate "The subtab was successfully approved."
      redirect_to :back
    else
      flash[:error] = translate "The subtab could not be approved."
      redirect_to :back
    end
  end

  def deny
    @subtab = Subtab.find(params[:id])
    @subtab.update approved: false
    Note.notify(current_user, User.find(@subtab.user_id),
      :subtab_denied, @subtab.id)
    redirect_to :back
  end
  
  def new
    @subtab = Subtab.new
  end
  
  def create
    @subtab = Subtab.new(params[:subtab].permit(:icon, :name, :description))
    @subtab.user_id = current_user.id
    @subtab.tab_id = params[:tab_id]
    @subtab.approved = true if current_user.admin
    
    if @subtab.save
      flash[:notice] = translate "Your subtab was successfully submitted."
      redirect_to tab_path(@subtab.tab_id)
    else
      flash[:error] = translate "Invalid input"
      redirect_to :back
    end
  end
  
  def index
    @tab = Tab.find(params[:tab_id])
    @subtabs = @tab.subtabs.approved.reverse
  end
  
  def show
    @advert = Article.local_advert(current_user)
    @subtab = Subtab.find(params[:id])
    @posts = @subtab.posts.reverse
    @post = Post.new
  end
end
