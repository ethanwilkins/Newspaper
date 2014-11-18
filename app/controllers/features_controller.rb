class FeaturesController < ApplicationController
  def new
    @tab = Tab.find(params[:tab_id])
    @feature = Feature.new
  end
  
  def create
    @tab = Tab.find(params[:tab_id])
    @feature = Feature.new(params[:feature].permit(:action))
    @feature.user_id = current_user.id
    @feature.tab_id = @tab.id
    
    if @feature.save
      flash[:notice] = translate("Feature added successfully.")
      redirect_to tab_path(@tab)
    else
      flash[:error] = translate("Invalid input.")
      redirect_to :back
    end
  end
end
