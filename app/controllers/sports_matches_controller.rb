class SportsMatchesController < ApplicationController
  def new
    @match = SportsMatch.new
  end
  
  def create
		@match = SportsMatch.new(params[:sports_match].permit(:exhibition, :icon))
    if @match.save
    	params.each do |key, value|
    		if key.include? "team_"
    			@match.members.create(sports_team_id: value)
    		end
    	end
      log_action("sports_matches_create")
      redirect_to @match
    else
      flash[:error] = translate("The match could not be saved")
      log_action("sports_matches_create_fail")
      redirect_to :back
    end
  end
  
  def show
    @match = SportsMatch.find(params[:id])
  end
  
  def edit
  end
  
  def update
  end
end
