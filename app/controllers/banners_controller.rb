class BannersController < ApplicationController
  def index
    @banner = Banner.active
    @banners = Banner.all.reverse
  end
  
  def create
    
  end
  
  def destroy
    
  end
  
  def new
    @banner = Banner.new
  end
  
  def edit
    @banner = Banner.find(params[:id])
  end
  
  def update
    
  end
end
