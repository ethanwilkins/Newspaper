class ActivitiesController < ApplicationController
  def index
    @activities = Activity.all
    @unique_locations = Activity.unique_locations
    Activity.log_action(current_user, request.remote_ip.to_s, "activities_index")
  end
end
