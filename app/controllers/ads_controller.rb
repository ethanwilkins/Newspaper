class AdsController < ApplicationController
  def create
    @ad = Ad.new(params[:ad].permit(:image, :advertiser, :zip_code))
    
    if @ad.save
      redirect_to :back
    else
      flash[:error] = "Invalid input"
      redirect_to :back
    end
  end
  
  def update
    @ad = Ad.find(params[:id])
    @ad.update(params[:ad].permit(:image, :advertiser, :zip_code))
    redirect_to :back
  end
  
  def destroy
    @ad = Ad.find(params[:id])
    
    if @ad.destroy
      redirect_to :back
    end
  end
  
  def index
    @ad = Ad.new
    @ads = Ad.all.reverse
  end
  
  def show
    @ad = Ad.find(params[:id])
  end
  
  def edit
    @ad = Ad.find(params[:id])
  end
end
