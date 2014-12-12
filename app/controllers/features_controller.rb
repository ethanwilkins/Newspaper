class FeaturesController < ApplicationController
  def cherry_pick
    @feature = current_user.features.new(action: :cherry_pick, tab_id: params[:tab_id])
    if @feature.save
      flash[:notice] = translate("Cherry pick saved successfully.")
      Activity.log_action(current_user, request.remote_ip.to_s, "features_cherry_pick", @feature.id)
    else
      flash[:error] = translate("Cherry pick failed to save.")
      Activity.log_action(current_user, request.remote_ip.to_s, "features_cherry_pick_fail", @feature.id)
    end
    redirect_to :back
  end
  
  def page_jump
    @feature = current_user.features.new(action: :page_jump, tab_id: params[:tab_id])
    if @feature.save
      flash[:notice] = translate("Page jump saved successfully.")
      Activity.log_action(current_user, request.remote_ip.to_s, "features_page_jump", @feature.id)
    else
      flash[:error] = translate("Page jump failed to save.")
      Activity.log_action(current_user, request.remote_ip.to_s, "features_page_jump_fail", @feature.id)
    end
    redirect_to :back
  end
  
  def new
    @tab = Tab.find(params[:tab_id])
    @feature = Feature.new
    Activity.log_action(current_user, request.remote_ip.to_s, "features_new")
  end
  
  def create
    @tab = Tab.find(params[:tab_id])
    @feature = Feature.new(params[:feature].permit(:action))
    @feature.user_id = current_user.id
    @feature.tab_id = @tab.id
    
    if @feature.save
      flash[:notice] = translate("Feature added successfully.")
      Activity.log_action(current_user, request.remote_ip.to_s, "features_create", @feature.id)
      redirect_to tab_path(@tab)
    else
      flash[:error] = translate("Invalid input.")
      Activity.log_action(current_user, request.remote_ip.to_s, "features_create_fail")
      redirect_to :back
    end
  end
end
