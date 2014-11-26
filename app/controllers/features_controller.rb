class FeaturesController < ApplicationController
  def page_jump
    @feature = current_user.features.new(action: :page_jump, tab_id: params[:tab_id])
    if @feature.save
      flash[:notice] = translate("Page jump saved successfully.")
    else
      flash[:error] = translate("Page jump failed to save.")
    end
    redirect_to :back
  end
  
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
