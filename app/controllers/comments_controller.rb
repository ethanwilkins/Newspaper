class CommentsController < ApplicationController
  def up_vote
    @comment = Comment.find(params[:id])
    Vote.up_vote!(@comment, current_user)
    log_action("comments_up_vote", @comment.id)
    redirect_to :back
  end
  
  def un_vote
    @comment = Comment.find(params[:id])
    Vote.un_vote!(@comment, current_user)
    log_action("comments_down_vote", @comment.id)
    redirect_to :back
  end

  def show
    @comment = Comment.find_by_id(params[:id])
    if @comment
      @new_comment = Comment.new
      @replies = @comment.comments.reverse
      log_action("comments_show", @comment.id)
      save_search @comment
    else
      log_action("comments_show_fail")
    end
  end
  
  def create
    @comment = Comment.new(params[:comment].permit(:body))
    @comment.user_id = current_user.id
    @comment.post_id = params[:post_id]
    @comment.article_id = params[:article_id]
    @comment.comment_id = params[:comment_id]
    
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
      Hashtag.extract(@comment)
      Note.notify(current_user, @user, action, item_id)
      log_action("comments_create", @comment.id)
      redirect_to :back
    else
      flash[:error] = translate "Invalid input"
      log_action("comments_create_fail")
      redirect_to :back
    end
  end
  
  def destroy
  end
end
