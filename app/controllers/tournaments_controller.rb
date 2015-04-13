class TournamentsController < ApplicationController
	def new
		@tournament = Tournament.new
	end
	
	def create
	end
	
	def show
		@tournament = Tournament.find(params[:id])
	end
	
	def index
		@tournaments = Tournament.all
	end
end
