class FeaturesController < ApplicationController
  def un_cherry_pick
    cherry_picks = current_user.features.where(action: :cherry_pick)
    @feature = cherry_picks.find_by_tab_id(params[:tab_id]) if cherry_picks.present?
    if @feature and @feature.destroy
      flash[:notice] = translate("Cherry pick removed successfully.")
      log_action("features_un_cherry_pick")
    else
      flash[:error] = translate("Cherry pick couldn't be removed.")
      log_action("features_un_cherry_pick_fail", (@feature ? @feature.id : nil))
    end
    redirect_to :back
  end
  
  def cherry_pick
    @feature = current_user.features.new(action: :cherry_pick, tab_id: params[:tab_id])
    if @feature.save
      flash[:notice] = translate("Cherry pick saved successfully.")
      log_action("features_cherry_pick", @feature.id)
    else
      flash[:error] = translate("Cherry pick failed to save.")
      log_action("features_cherry_pick_fail", @feature.id)
    end
    redirect_to :back
  end
  
  def page_jump
    @feature = current_user.features.new(action: :page_jump, tab_id: params[:tab_id])
    if @feature.save
      flash[:notice] = translate("Page jump saved successfully.")
      log_action("features_page_jump", @feature.id)
    else
      flash[:error] = translate("Page jump failed to save.")
      log_action("features_page_jump_fail", @feature.id)
    end
    redirect_to :back
  end
  
  def new
    @tab = Tab.find_by_id(params[:tab_id])
    @user = User.find_by_name(params[:user_id])
    @feature = Feature.new
    log_action("features_new")
  end
  
  def create
    @user = User.find_by_id(params[:user_id])
    @tab = Tab.find_by_id(params[:tab_id])
    @feature = Feature.new(params[:feature].permit(:action))
    @feature.user_id = @user.id if @user
    @feature.tab_id = @tab.id if @tab
    
    if @feature.save
      flash[:notice] = translate("Feature added successfully.")
      log_action("features_create", @feature.id)
      redirect_to user_path(@user.name) if @user
      redirect_to tab_path(@tab) if @tab
    else
      flash[:error] = translate("Invalid input.")
      log_action("features_create_fail")
      redirect_to :back
    end
  end
  
  def destroy
    @feature = Feature.find(params[:id])
    if @feature.destroy
      flash[:notice] = translate("Feature removed successfully.")
    else
      flash[:error] = translate("Feature could not removed.")
    end
    redirect_to :back
  end
end
