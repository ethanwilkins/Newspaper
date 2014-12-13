class ActivitiesController < ApplicationController
  def index
    reset_page
    @activities = Activity.all.reverse.
        # drops first several posts if :feed_page
        drop((session[:page] ? session[:page] : 0) * page_size).
        # only shows first several posts of resulting array
        first(page_size)
    @unique_locations = Activity.unique_locations
    Activity.log_action(current_user, request.remote_ip.to_s, "activities_index")
  end
  
  def show
    @activity = Activity.find(params[:id])
    Activity.log_action(current_user, request.remote_ip.to_s, "activities_show", @activity.id)
  end
  
  def unique_locations
    reset_page
    @unique_locations = Activity.unique_locations.reverse.
        # drops first several posts if :feed_page
        drop((session[:page] ? session[:page] : 0) * page_size).
        # only shows first several posts of resulting array
        first(page_size)
    Activity.log_action(current_user, request.remote_ip.to_s, "activities_unique_locations")
  end
end
