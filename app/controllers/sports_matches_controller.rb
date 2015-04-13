class SportsMatchesController < ApplicationController
  def new
    @match = SportsMatch.new
  end
  
  def create
		@match = SportsMatch.new(params[:sports_match].permit(:exhibition, :icon))
    if @match.save
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
