class TranslationsController < ApplicationController
  def new
    @translation = Translation.new
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
end
