class SportsMatchesController < ApplicationController
  def new
    @match = SportsMatch.new
  end
  
  def create
  end
  
  def show
    @match = SportsMatch.find(params[:id])
  end
  
  def edit
  end
  
  def update
  end
end
