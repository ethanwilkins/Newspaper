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
    @post.tab_id = params[:tab_id]
    @post.subtab_id = params[:subtab_id]
    
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
    @advert = Article.local_advert(current_user)
    @posts = Post.all.reverse
    @post = Post.new
  end
  
  def jokes
    @advert = Article.local_advert(current_user)
    @jokes = Post.jokes.reverse
    @post = Post.new
  end
  
  def questions
    @advert = Article.local_advert(current_user)
    @questions = Post.questions.reverse
    @post = Post.new
  end
  
  def art
    @advert = Article.local_advert(current_user)
    @art = Post.art.reverse
    @post = Post.new
  end
end
