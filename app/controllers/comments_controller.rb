class CommentsController < ApplicationController
  def show
    @comment = Comment.find(params[:id])
    @replies = @comment.comments.reverse
    @new_comment = Comment.new
  end
  
  def create
    @comment = Comment.new(params[:comment].permit(:text))
    @comment.user_id = current_user.id
    @comment.post_id ||= params[:post_id]
    @comment.article_id ||= params[:article_id]
    @comment.comment_id ||= params[:comment_id]
    
    @user = if @comment.post_id
              action = :post_comment
              item_id = @comment.post_id
              User.find(Post.find(@comment.post_id).user_id)
              
            elsif @comment.article_id
              action = :article_comment
              item_id = @comment.article_id
              User.find(Article.find(@comment.article_id).user_id)
              
            elsif @comment.comment_id
              action = :comment_reply
              item_id = @comment.comment_id
              User.find(Comment.find(@comment.comment_id).user_id)
            end
    
    if @comment.save
      Note.notify(current_user, @user, action, item_id)
      redirect_to :back
    else
      flash[:error] = "Invalid input"
      redirect_to :back
    end
  end
  
  def destroy
  end
end
