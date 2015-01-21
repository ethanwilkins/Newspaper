class FeedbacksController < ApplicationController
  def new
    @post = get_item("Post", params[:post_id])
    @article = get_item("Article", params[:article_id])
    @comment = get_item("Comment", params[:comment_id])
    @event = get_item("Event", params[:event_id])
    @tab = get_item("Tab", params[:tab_id])
    
    # all items into array and gets the non-nil one
    @items = [@post, @article, @comment, @event, @tab]
    @item = chosen_one @items
    
    # determines whether user already has feedbacks
    if @item.feedbacks.exists? user_id: current_user.id
      @feedback = @item.feedbacks.find_by_user_id current_user.id
    else
      @feedback = Feedback.new
    end
  end
  
  def create
    @feedback = Feedback.new(stars: params[:stars], user_id: current_user.id)
    @feedback.review = params[:feedback][:review] if params[:feedback]
    @feedback.article_id = session[:article_id]
    @feedback.comment_id = session[:comment_id]
    @feedback.event_id = session[:event_id]
    @feedback.post_id = session[:post_id]
    
    if @feedback.save
      flash[:notice] = translate("Feedback saved successfully.")
    else
      flash[:error] = translate("Feedback could not be saved.")
    end
    redirect_to :back
  end
  
  def update
    @feedback = Feedback.find_by_id params[:feedback_id]
    if @feedback and @feedback.update(update_feedback_params)
      flash[:notice] = translate("Feedback updated successfully.")
    else
      flash[:error] = translate("Feedback could not be updated.")
    end
    redirect_to :back
  end
  
  private
  
  def update_feedback_params
    return params.require(:feedback).permit(:review) if params[:feedback]
    { stars: params[:stars] } if params[:stars]
  end
end