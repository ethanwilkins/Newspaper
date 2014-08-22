class PostsController < ApplicationController
  def up_vote
    @post = Post.find(params[:id])
    Vote.up_vote!(@post, current_user)
    Note.notify(current_user, User.find(@post.user_id), :like_post, @post.id)
    redirect_to :back
  end
  
  def un_vote
    @post = Post.find(params[:id])
    Vote.un_vote!(@post, current_user)
    redirect_to :back
  end

  def create
    @post = current_user.posts.new(params[:post].permit(:title, :body, :image))
    @post.question = params[:question]
    @post.joke = params[:joke]
    @post.art = params[:art]
    
    if @post.save
      Hashtag.extract(@post) if @post.body
      redirect_to :back
    else
      flash[:error] = "Invalid input"
      redirect_to :back
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.reverse
    @new_comment = Comment.new
  end
  
  def index
    @posts = Post.all.reverse
    @post = Post.new
  end
  
  def jokes
    @jokes = Post.jokes.reverse
    @post = Post.new
  end
  
  def questions
    @questions = Post.questions.reverse
    @post = Post.new
  end
  
  def art
    @art = Post.art.reverse
    @post = Post.new
  end
end
