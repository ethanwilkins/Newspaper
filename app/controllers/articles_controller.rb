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
  
  def ad_edit
    @advert = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end
  
  def update
    @article = Article.find(params[:id])
    @article.update(params[:article].permit(:title, :body, :image, :zip_code))
    
    if @article.ad
      redirect_to ad_index_path
    else
      redirect_to root_url
    end
  end
  
  def create
    @article = Article.new(params[:article].permit(:title, :body, :image, :zip_code, :hyperlink))
    @article.user_id = current_user.id
    @article.ad = params[:ad]
    
    if @article.save and @article.ad
      flash[:notice] = translate "Advertisement saved successfully."
      redirect_to :back
      
    elsif @article.save
      redirect_to articles_path
      
    else
      flash[:error] = translate "Invalid input"
      redirect_to :back
    end
  end
  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to :back
  end
end
