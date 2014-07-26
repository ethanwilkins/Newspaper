class CommentsController < ApplicationController
  def create
    @comment = Comment.new(params[:comment].permit(:text))
    @comment.user_id = current_user.id
    @comment.post_id ||= params[:post_id]
    @comment.article_id ||= params[:article_id]
    @comment.comment_id ||= params[:comment_id]
    
    if @comment.save
      redirect_to :back
    else
      flash[:error] = "Invalid input"
      redirect_to :back
    end
  end
  
  def destroy
  end
end
