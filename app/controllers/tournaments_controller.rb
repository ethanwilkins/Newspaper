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
      # creates teams
    	params.each do |key, value|
    		if key.include? "team_"
    			@tournament.members.create(sports_team_id: value)
    		end
    	end
      # creates team pairs, best with worst
      @teams = @tournament.teams.sort_by { |team| team.points }
      pairs = (@teams.size/2).times.map do
      	[@teams.shift, @teams.pop]
      end
      # need to account for outliers, reserving
      # some pairs for the second or
      # third set of tournament matches
      # number of matches based on team pool size
      
      # inserts team pairs into matches
      for pair in pairs
      	# need to figure out a way to correctly set
      	# aside outliers and the number of matches
				# unless pairs.index(pair) < pairs.size / 2
	  		match = @tournament.matches.create
	  		match.members.create(sports_team_id: pair.first.id)
	  		match.members.create(sports_team_id: pair.last.id)
				# end
    	end
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
