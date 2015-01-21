class BannersController < ApplicationController
  def index
    @banner = Banner.last
    @new_banner = Banner.new
    log_action("banners_index")
  end
  
  def show
    @banner = Banner.find(params[:id])
    @comments = @banner.comments.reverse
    @new_comment = Comment.new
  end
  
  def create
    @banner = Banner.new(params[:banner].permit(:image))
    @banner.user_id = current_user.id
    
    if @banner.save
      log_action("banners_create", @banner.id)
      redirect_to :back
    else
      flash[:error] = translate("Invalid input")
      log_action("banners_create_fail")
      redirect_to :back
    end
  end
  
  def destroy
    @banner = Banner.find(param[:id])
    @banner.destroy
    log_action("banners_destroy")
    redirect_to :back
  end
  
  def update
    @banner = Banner.find(params[:id])
    @banner.update(params[:banner].permit(:image))
    log_action("banners_update", @banner.id)
    redirect_to :back
  end
end
