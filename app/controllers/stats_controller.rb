class StatsController < ApplicationController
  def new
  	@stat = Stat.new
  end

  def create
  	@stat = Stat.new(params[:stat].permit(:finished))
  	@match = SportsMatch.find_by_id(params[:sports_match_id])
  	@stat.sports_match_id = @match.id if @match
  	if @stat.finished
			scores = [params[:team_1_score].to_i,
				params[:team_2_score].to_i].sort!
			@stat.winning_score = scores.last
			@stat.losing_score = scores.first
			@stat.finished = true
		end
  	if @stat.save
  		flash[:notice] = translate("Stats saved successfully")
  	else
  		flash[:error] = translate("Stats could not be saved")
  	end
  	redirect_to :back
  end
end
