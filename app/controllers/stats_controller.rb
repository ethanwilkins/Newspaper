class StatsController < ApplicationController
  def new
  	@stat = Stat.new
  end

  def create
  	@stat = Stat.new(params[:stat].permit(:finished, :sports_match_id, :image))
    @stat.first_teams_score = str_to_a(params[:team_1]).last
    @stat.second_teams_score = str_to_a(params[:team_2]).last
  	if @stat.finished
			scores = [str_to_a(params[:team_1]), str_to_a(params[:team_2])].
        sort_by { |team| team.last.to_i }
      unless scores.last.last.to_i.eql? scores.first.last.to_i
		    @stat.winning_team_id = scores.last.first.to_i
		    @stat.losing_team_id = scores.first.first.to_i
				@stat.winning_score = scores.last.last.to_i
				@stat.losing_score = scores.first.last.to_i
			end
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
