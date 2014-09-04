class TabsController < ApplicationController
  def pending
    @tabs = Tab.pending.reverse
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
    
    if @tab.save
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
    @posts = @tab.posts.reverse
    @post = Post.new
  end
end
