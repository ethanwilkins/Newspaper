class ActivitiesController < ApplicationController
  def index
    @activities = Activity.all
    @unique_locations = Activity.unique_locations
  end
end
