class TabsController < ApplicationController
  def pending
    @tabs = Tab.pending.reverse
    @subtabs = Subtab.pending.reverse
  end
  
  def approve
    @tab = Tab.find(params[:id])
    @tab.update approved: true
    Note.notify(current_user, User.find(@tab.user_id),
      :tab_approved, @tab.id)
    redirect_to :back
  end

  def deny
    @tab = Tab.find(params[:id])
    @tab.update approved: false
    Note.notify(current_user, User.find(@tab.user_id),
      :tab_denied, @tab.id)
    redirect_to :back
  end
  
  def new
    @tab = Tab.new
  end
  
  def create
    @tab = Tab.new(params[:tab].permit(:icon, :name, :description))
    @tab.user_id = current_user.id
    
    if @tab.save
      flash[:notice] = "Your tab was successfully submitted."
      redirect_to tabs_path
    else
      flash[:error] = "Invalid input"
      redirect_to :back
    end
  end
  
  def index
    @tabs = Tab.approved.reverse
  end
  
  def show
    @advert = Article.local_advert(current_user)
    @tab = Tab.find(params[:id])
    @subtabs = @tab.popular_subtabs
    @posts = @tab.posts.reverse
    @post = Post.new
  end
end
