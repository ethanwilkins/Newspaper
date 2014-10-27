class BannersController < ApplicationController
  def index
    @banner = Banner.last
    @new_banner = Banner.new
    Activity.log_action(current_user, request.remote_ip.to_s, "banners_index")
  end
  
  def create
    @banner = Banner.new(params[:banner].permit(:image))
    
    if @banner.save
      Activity.log_action(current_user, request.remote_ip.to_s, "banners_create", @banner.id)
      redirect_to :back
    else
      flash[:error] = translate("Invalid input")
      Activity.log_action(current_user, request.remote_ip.to_s, "banners_create_fail")
      redirect_to :back
    end
  end
  
  def destroy
    @banner = Banner.find(param[:id])
    @banner.destroy
    Activity.log_action(current_user, request.remote_ip.to_s, "banners_destroy")
    redirect_to :back
  end
  
  def update
    @banner = Banner.find(params[:id])
    @banner.update(params[:banner].permit(:image))
    Activity.log_action(current_user, request.remote_ip.to_s, "banners_update", @banner.id)
    redirect_to :back
  end
end
