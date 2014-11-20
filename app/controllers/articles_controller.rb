class ArticlesController < ApplicationController
  def index
    @articles = Article.all.reverse
    Activity.log_action(current_user, request.remote_ip.to_s, "articles_index")
  end
  
  def ad_index
    @advert = Article.new
    @adverts = Article.ads.reverse
    Activity.log_action(current_user, request.remote_ip.to_s, "articles_ad_index")
  end

  def show
    @article = Article.find_by_id(params[:id])
    if @article
      @comments = @article.comments.reverse
      @new_comment = Comment.new
      Activity.log_action(current_user, request.remote_ip.to_s, "articles_show", @article.id)
    end
  end
  
  def ad_edit
    @advert = Article.find(params[:id])
    Activity.log_action(current_user, request.remote_ip.to_s, "articles_ad_edit", @advert.id)
  end
  
  def edit
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
    @articles = Article.all
    Activity.log_action(current_user, request.remote_ip.to_s, "articles_new")
  end
  
  def update
    @article = Article.find(params[:id])
    @article.update(params[:article].permit(:title, :body, :image, :zip_code, :english_version))
    
    if @article.ad
      flash[:notice] = translate("Advert successfully updated.")
      redirect_to ad_index_path
    elsif @article
      flash[:notice] = translate("Article succussfully updated.")
      redirect_to root_url
    else
      flash[:error] = translate("Invalid input.")
      redirect_to :back
    end
    Activity.log_action(current_user, request.remote_ip.to_s, "articles_update", @article.id)
  end
  
  def create
    @article = Article.new(params[:article].permit(:title, :body, :image, :zip_code, :hyperlink, :english_version))
    @article.user_id = current_user.id
    @article.ad = params[:ad]
    
    if @article.save and @article.ad
      flash[:notice] = translate "Advertisement saved successfully."
      Activity.log_action(current_user, request.remote_ip.to_s, "articles_create_ad", @article.id)
      redirect_to :back
      
    elsif @article.save
      Activity.log_action(current_user, request.remote_ip.to_s, "articles_create", @article.id)
      redirect_to root_url
      
    else
      flash[:error] = translate "Invalid input"
      Activity.log_action(current_user, request.remote_ip.to_s, "articles_create_fail")
      redirect_to :back
    end
  end
  
  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      flash[:notice] = translate("Article successfully deleted.")
      Activity.log_action(current_user, request.remote_ip.to_s, "articles_destroy")
    else
      flash[:error] = translate("Article could not be deleted.")
    end
    redirect_to :back
  end
end
