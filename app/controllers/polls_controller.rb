class PollsController < ApplicationController
  def add_choice
    @choice_num = params[:choice_num].to_i
    @choice_num += 1
  end
  
  def create
    @poll = Poll.new poll_params
    if @poll.save
      # assembles choices
      params.each do |key, param|
        if key.include? "choice" and param.present?
          @poll.choices.create text: param
        end
      end
      flash[:notice] = translate("The poll saved successfully")
      log_action("polls_create")
      redirect_to @poll
    else
      flash[:error] = translate("The poll could not be saved")
      log_action("polls_create_fail")
      redirect_to :back
    end
  end
  
  def new
    @poll = Poll.new
    log_action("polls_new")
  end
  
  def show
    @poll = Poll.find_by_id(params[:id])
    @choices = @poll.choices.sort_by { |poll| poll.score }.reverse
    log_action("polls_show")
  end
  
  def destroy
    @poll = Poll.find(params[:id])
    user_id = @poll.user_id
    tab_id = @poll.tab_id
    if @poll.destroy
      flash[:notice] = translate("The poll was deleted")
      log_action("polls_destroy")
      if user_id
        redirect_to user_path(User.find(user_id).name)
      elsif tab_id
        redirect_to tab_path(tab_id)
      end
    else
      flash[:error] = translate("The poll could not be deleted")
      log_action("polls_destroy_fail")
      redirect_to :back
    end
  end
  
  def edit
    @poll = Poll.find(params[:id])
    log_action("polls_edit")
  end
  
  def up_vote
    @poll = Poll.find(params[:poll_id])
    @choice = @poll.choices.find(params[:choice_id]) if @poll
    if @choice
      Vote.up_vote! @choice, current_user
      log_action("polls_up_vote", @poll.id)
    end
    redirect_to :back
  end
  
  def down_vote
    @poll = Poll.find(params[:poll_id])
    @choice = @poll.choices.find(params[:choice_id]) if @poll
    if @choice
      Vote.down_vote! @choice, current_user
      log_action("polls_down_vote", @poll.id)
    end
    redirect_to :back
  end
  
  private
  
  def poll_params
    params[:poll].permit(:tab_id, :question, :image)
  end
end
