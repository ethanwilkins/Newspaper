class FeaturesController < ApplicationController
  def un_cherry_pick
    cherry_picks = current_user.features.where(action: :cherry_pick)
    if cherry_picks.present?
      if params[:subtab_id]
        @feature = cherry_picks.find_by_subtab_id(params[:subtab_id])
      elsif params[:tab_id]
        @feature = cherry_picks.find_by_tab_id(params[:tab_id])
      end
    end
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
    if params[:subtab_id]
      @feature = current_user.features.new(action: :cherry_pick, subtab_id: params[:subtab_id])
    elsif params[:tab_id]
      @feature = current_user.features.new(action: :cherry_pick, tab_id: params[:tab_id])
    end
    @feature.personal = true
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
    @feature.personal = true
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
    if params[:subtab_id]
      @subtab = Subtab.find_by_id(params[:subtab_id])
    elsif params[:tab_id]
      @tab = Tab.find_by_id(params[:tab_id])
    end
    @user = User.find_by_name(params[:user_id])
    @feature = Feature.new
    log_action("features_new")
  end
  
  def create
    @tab = Tab.find_by_id(params[:tab_id])
    @subtab = Subtab.find_by_id(params[:subtab_id])
    @feature = Feature.new(params[:feature].permit(:action))
    @user = User.find_by_id(params[:user_id])
    @feature.user_id = @user.id if @user
    
    if @subtab
      @feature.subtab_id = @subtab.id
    elsif @tab
      @feature.tab_id = @tab.id
    end
    
    if @feature.save
      flash[:notice] = translate("Feature added successfully.")
      log_action("features_create", @feature.id)
      if @subtab
        redirect_to tab_subtab_path(@subtab.tab, @subtab)
      elsif @tab
        redirect_to tab_path(@tab)
      elsif @user
        redirect_to user_path(@user.name)
      end
    else
      flash[:error] = translate("Invalid input.")
      log_action("features_create_fail")
      redirect_to :back
    end
  end
  
  def destroy
    @feature = Feature.find(params[:id])
    if @feature.user and @feature.personal
      @user = @feature.user
    elsif @feature.tab
      @tab = @feature.tab
    end
    
    if @feature.destroy
      flash[:notice] = translate("Feature removed successfully.")
      log_action("")
    else
      flash[:error] = translate("Feature could not removed.")
    end
    
    if @user
      redirect_to user_path(@user.name)
    else
      redirect_to tab_path(@tab)
    end
  end
end
