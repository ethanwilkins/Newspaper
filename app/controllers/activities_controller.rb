class ActivitiesController < ApplicationController
  def destroy_all
    Activity.destroy_all
    redirect_to :back
  end
  
  def get_location
    @activity = Activity.find_by_id(params[:id])
    if @activity.get_location and @activity.save
      flash[:notice] = translate("Location successfully saved.")
      log_action("activities_get_location", @activity.id)
    else
      flash[:error] = translate("Location could not be saved.")
      log_action("activities_get_location_fail", @activity.id)
    end
    redirect_to activity_path(@activity)
  end
  
  def unique_locations
    reset_page
    @unique_locations = paginate Activity.unique_locations
    log_action("activities_unique_locations")
  end
  
  def unique_visits
    reset_page
    @unique_visits = paginate Activity.unique_visits
    log_action("activities_unique_visits")
  end
  
  def index
    reset_page
    if params[:activity_action]
      @all_activities = Activity.where(action: params[:activity_action])
    elsif params[:activity_user_id]
      @all_activities = Activity.where(user_id: params[:activity_user_id])
    elsif params[:activity_address]
      @all_activities = Activity.where(address: params[:activity_address])
    elsif params[:activity_ip]
      @all_activities = Activity.where(ip: params[:activity_ip])
    else
      @all_activities = Activity.all
    end
    @activities = paginate(@all_activities)
    @unique_locations = Activity.unique_locations
    log_action("activities_index")
  end
  
  def show
    @activity = Activity.find(params[:id])
    @comments = @activity.comments
    @new_comment = Comment.new
    log_action("activities_show", @activity.id)
  end
end
