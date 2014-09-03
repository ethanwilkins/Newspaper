class TabsController < ApplicationController
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
    @tabs = Tab.all.reverse
  end
  
  def show
    @advert = Article.local_advert(current_user)
    @tab = Tab.find(params[:id])
    @posts = @tab.posts.reverse
    @post = Post.new
  end
end
