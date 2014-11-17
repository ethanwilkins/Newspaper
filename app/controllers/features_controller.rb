class FeaturesController < ApplicationController
  def new
    @tab = Tab.find(params[:tab_id])
    @feature = Feature.new
  end
  
  def create
    @feature = Feature.new(params[:feature].permit(:action))
    @feature.user_id = current_user.id
    @feature.tab_id = params[:tab_id]
    
    if @feature.save
      flash[:notice] = translate("Feature saved successfully.")
      redirect_to :back
    else
      flash[:error] = translate("Invalid input.")
      redirect_to :back
    end
  end
end
