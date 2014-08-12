class PostsController < ApplicationController
  def create
    @post = current_user.posts.new(params[:post].permit(:title, :body, :image))
    @post.question = params[:question]
    @post.joke = params[:joke]
    
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
    @jokes = Post.jokes
    @post = Post.new
  end
  
  def questions
    @questions = Post.questions
    @post = Post.new
  end
end
