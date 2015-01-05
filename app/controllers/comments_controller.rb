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
    @comment.translation_id = params[:translation_id]
    @comment.activity_id = params[:activity_id]
    @comment.article_id = params[:article_id]
    @comment.comment_id = params[:comment_id]
    @comment.event_id = params[:event_id]
    @comment.post_id = params[:post_id]
    
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
            
            elsif @comment.event_id
              action = :event_comment
              item_id = @comment
              User.find(Event.find(@comment.event_id).user_id)
              
            elsif @comment.activity_id and Activity.find(@comment.activity_id).user_id.present?
              action = :activity_comment
              item_id = @comment.activity_id
              User.find(Activity.find(@comment.activity_id).user_id)
              
            elsif @comment.translation_id and Translation.find(@comment.translation_id).user_id.present?
              action = :translation_comment
              item_id = @comment.translation_id
              User.find(Translation.find(@comment.translation_id).user_id)
            end
    
    if @comment.save
      if (@comment.activity_id.nil? or @comment.translation_id.nil?) \
        or (@user and (@user.admin or @user.master))
        Note.notify(current_user, @user, action, item_id)
      end
      current_user.notify_mentioned(@comment)
      Hashtag.extract(@comment)
      log_action("comments_create", @comment.id)
      redirect_to :back
    else
      flash[:error] = translate "Invalid input"
      log_action("comments_create_fail")
      redirect_to :back
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:notice] = translate("Comment successfully deleted.")
      log_action("comments_destroy")
    else
      flash[:error] = translate("Comment could not be deleted.")
      log_action("comments_destroy_fail", @comment.id)
    end
    redirect_to :back
  end
end
