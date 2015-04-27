class TournamentsController < ApplicationController
  def add_team
    @team_num = params[:team_num].to_i
    @team_num += 1
  end
  
	def new
		@tournament = Tournament.new
	end
	
	def create
    @tab = Tab.find_by_id(params[:tab_id])
		@tournament = @tab.tournaments.
      new(tournament_params) if @tab
    if @tournament and @tournament.save
    	@tournament.assemble params
      log_action("tournaments_create")
      redirect_to tab_tournament_path(@tab, @tournament)
    else
      flash[:error] = translate("The tournament could not be saved")
      log_action("tournaments_create_fail")
      redirect_to :back
    end
	end
	
	def show
		@tournament = Tournament.find(params[:id])
	end
	
	def index
		@tournaments = Tournament.all
	end
	
	private
  
  def tournament_params
    if params[:tournament]
      params[:tournament].permit(:icon, :date, :location)
    end
  end
end
