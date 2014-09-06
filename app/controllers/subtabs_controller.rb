class SubtabsController < ApplicationController
  def pending
    @subtabs = Subtab.pending.reverse
  end
  
  def approve
    @subtab = Subtab.find(params[:id])
    @subtab.update approved: true
    Note.notify(current_user, User.find(@subtab.user_id),
      :subtab_approved, @subtab.id)
    redirect_to :back
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
    @subtab = Subtab.new(params[:tab].permit(:icon, :name, :description))
    @subtab.user_id = current_user.id
    
    if @subtab.save
      flash[:notice] = "Your subtab was successfully submitted."
      redirect_to subtabs_path
    else
      flash[:error] = "Invalid input"
      redirect_to :back
    end
  end
  
  def index
    @subtabs = Subtab.approved.reverse
  end
  
  def show
    @advert = Article.local_advert(current_user)
    @subtab = Subtab.find(params[:id])
    @posts = @subtab.posts.reverse
    @post = Post.new
  end
end
