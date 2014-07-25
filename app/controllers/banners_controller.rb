class BannersController < ApplicationController
  def index
    @banner = Banner.last
    @new_banner = Banner.new
  end
  
  def create
    @banner = Banner.new(params[:banner].permit(:image))
    
    if @banner.save
      redirect_to :back
    else
      flash[:error] = "Invalid input"
      redirect_to :back
    end
  end
  
  def destroy
    @banner = Banner.find(param[:id])
    @banner.destroy
    redirect_to :back
  end
  
  def update
    @banner = Banner.find(params[:id])
    @banner.update(params[:banner].permit(:image))
    redirect_to :back
  end
end
