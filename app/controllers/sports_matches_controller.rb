class SportsMatchesController < ApplicationController
  def new
    @match = SportsMatch.new
  end
  
  def create
    @tab = Tab.find(params[:tab_id])
		@match = @tab.sports_matches.new(match_params) if @tab
    if @match and @match.save
    	params.each do |key, value|
    		if key.include? "team_"
    			@match.members.create(sports_team_id: value)
    		end
    	end
      log_action("sports_matches_create")
      redirect_to tab_sports_match_path(@tab, @match)
    else
      flash[:error] = translate("The match could not be saved")
      log_action("sports_matches_create_fail")
      redirect_to :back
    end
  end
  
  def update
		@match = SportsMatch.find_by_id(params[:id])
    if @match.update(match_params)
      log_action("sports_matches_update")
      redirect_to @match
    else
      flash[:error] = translate("The match could not be updated")
      log_action("sports_matches_update_fail")
      redirect_to :back
    end
  end
  
  def show
    @match = SportsMatch.find(params[:id])
    @stat = Stat.new
  end
  
  def edit
    @match = SportsMatch.find(params[:id])
  end
  
  private
  
  def match_params
    if params[:sports_match]
      params[:sports_match].permit(:icon, :date, :location, :exhibition)
    end
  end
end
