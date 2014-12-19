class ActivitiesController < ApplicationController
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
    log_action("activities_show", @activity.id)
  end
  
  def unique_locations
    reset_page
    @unique_locations = Activity.unique_locations.reverse.
        # drops first several posts if :feed_page
        drop((session[:page] ? session[:page] : 0) * page_size).
        # only shows first several posts of resulting array
        first(page_size)
    log_action("activities_unique_locations")
  end
end
