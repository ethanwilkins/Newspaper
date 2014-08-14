class AdvertsController < ApplicationController
  def create
    @advert = Advert.new(params[:advert].permit(:image, :advertiser, :zip_code))
    
    if @advert.save
      redirect_to :back
    else
      flash[:error] = "Invalid input"
      redirect_to :back
    end
  end
  
  def update
    @advert = Advert.find(params[:id])
    @advert.update(params[:advert].permit(:image, :advertiser, :zip_code))
    redirect_to :back
  end
  
  def destroy
    @advert = Advert.find(params[:id])
    
    if @advert.destroy
      redirect_to :back
    end
  end
  
  def index
    @advert = Advert.new
    @adverts = Advert.all.reverse
  end
  
  def show
    @advert = Advert.find(params[:id])
  end
  
  def edit
    @advert = Advert.find(params[:id])
  end
end
