class PollsController < ApplicationController
  def create
    @poll = Poll.new poll_params
    
    if @poll.save
      
    end
  end
  
  def new
    
  end
  
  def destroy
    
  end
  
  def edit
    
  end
  
  def up_vote
    
  end
  
  def down_vote
    
  end
  
  private
  
  def poll_params
    params[:poll].permit(:tab_id, :subtab_id, :question, :proposal, :kind)
  end
end
