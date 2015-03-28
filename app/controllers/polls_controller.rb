class PollsController < ApplicationController  
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
  
  def add_choice
    @choice_num = params[:choice_num].to_i
    @choice_num += 1
  end
  
  def create
    @poll = current_user.polls.new poll_params if params[:user_id]
    @poll = Tab.find(params[:tab_id]).polls.new poll_params if params[:tab_id]
    @poll.user_id = current_user.id
    if @poll and @poll.save
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
    if params[:user_id]
      @user = current_user
    elsif params[:tab_id]
      @tab = Tab.find_by_id(params[:tab_id])
    end
    log_action("polls_new")
  end
  
  def show
    @poll = Poll.find_by_id(params[:id])
    @choices = @poll.choices
    @comments = @poll.comments.reverse
    @new_comment = Comment.new
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
  
  private
  
  def poll_params
    params[:poll].permit(:tab_id, :question, :image)
  end
end
