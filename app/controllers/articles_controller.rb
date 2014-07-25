class ArticlesController < ApplicationController
  def index
    @articles = Article.all.reverse
  end

  def show
    @article = Article.find(params[:id])
  end
  
  def edit
    @article = Article.find(params[:id])
    @article.update(params[:article].permit(:title, :body, :image))
  end

  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(params[:article].permit(:title, :body, :image))
    
    if @article.save
      redirect_to articles_path
    else
      flash[:error] = "Invalid input"
      redirect_to :back
    end
  end
end
