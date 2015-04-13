class SportsTeamsController < ApplicationController
	def new
		@team = SportsTeam.new
	end
	
	def create
		@team = SportsTeam.new(params[:sports_team].permit(:name, :icon))
    if @team.save
      log_action("sports_teams_create")
      redirect_to @team
    else
      flash[:error] = translate("The team could not be saved")
      log_action("sports_teams_create_fail")
      redirect_to :back
    end
	end
	
	def show
		@team = SportsTeam.find(params[:id])
	end
	
	def index
	end
end
