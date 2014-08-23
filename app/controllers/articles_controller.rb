class ArticlesController < ApplicationController
  def index
    @articles = Article.all.reverse
  end
  
  def ad_index
    @advert = Article.new
    @adverts = Article.ads.reverse
  end

  def show
    @article = Article.find(params[:id])
    @comments = @article.comments.reverse
    @new_comment = Comment.new
  end
  
  def edit
    @article = Article.find(params[:id])
    @article.update(params[:article].permit(:title, :body, :image))
  end

  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(params[:article].permit(:title, :body, :image, :zip_code, :hyperlink))
    @article.user_id = current_user.id
    @article.ad = params[:ad]
    
    if @article.save and @article.ad
      flash[:notice] = "Advertisement saved successfully."
      redirect_to :back
      
    elsif @article.save
      redirect_to articles_path
      
    else
      flash[:error] = "Invalid input"
      redirect_to :back
    end
  end
end
