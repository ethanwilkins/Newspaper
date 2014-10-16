class TranslationsController < ApplicationController
  def index
    @translation = Translation.new
    @translations = Translation.all.last(5).reverse
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def create
    @translation = Translation.new(params[:translation].permit(:english, :spanish))
    
    if @translation.save
      flash[:notice] = translate("Translation saved successfully.")
    else
      flash[:error] = translate("Translation could not be saved.")
    end
    redirect_to :back
  end
  
  def destroy
    
  end
end
