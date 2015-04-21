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
      # creates teams and matches
    	params.each do |key, value|
    		if key.include? "team_"
    			@tournament.members.create(sports_team_id: value)
        elsif key.eql? "num_of_matches"
          value.to_i.times do
            @tournament.sports_matches.create
          end
    		end
    	end
      # creates team pairs, best with worst
      @teams = @tournament.teams.sort_by { |team| team.points }
      # there's a problem with pair creation, some teams getting ignored
      # at about 10 teams, the 7th gets matched up with itself
      team_pairs = []; outliers = []; @teams.each do |team|
        if @teams.size >= 2
          team_pairs << [team, @teams.last]
          @teams.delete team; @teams.delete @teams.last
        else
          outliers << team
        end
      end
      # inserts team pairs into matches
      for match in @tournament.matches
    		match.members.new
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
