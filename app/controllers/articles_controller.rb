class ArticlesController < ApplicationController
  def ad_index
    @advert = Article.new
    @adverts = Article.ads.reverse
    log_action("articles_ad_index")
  end

  def show
    @article = Article.find_by_id(params[:id])
    if @article
      @comments = @article.comments
      @new_comment = Comment.new
      log_action("articles_show", @article.id)
      save_search @article
    else
      log_action("articles_show_fail")
    end
  end
  
  def ad_edit
    @advert = Article.find(params[:id])
    log_action("articles_ad_edit", @advert.id)
  end
  
  def edit
    @article = Article.find(params[:id])
  end

  def new
    if master? and session[:group_id]
      zips = []
      Group.find(session[:group_id]).zips.each { |zip| zips << zip.zip_code }
      @articles = Article.where(zip_code: zips)
    elsif master?
      @articles = Article.all
    elsif admin?
      zips = []
      current_user.group.zips.each { |zip| zips << zip.zip_code }
      @articles = Article.where(zip_code: zips)
    end
    @article = Article.new
    @tab = Tab.find_by_id(params[:tab_id])
    log_action("articles_new")
  end
  
  def update
    @article = Article.find(params[:id])
    @article.update(params[:article].permit(:title, :body, :image, :hyperlink))
    
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
    log_action("articles_update", @article.id)
  end
  
  def create
    @article = Article.new(params[:article].permit(:title, :body, :image,
      :hyperlink, :translation_requested))
    @article.zip_code = current_user.zip_code
    @article.user_id = current_user.id
    @article.tab_id = params[:tab_id]
    @article.ad = params[:ad]
    
    if @article.tab_id and not privileged?
      @article.requires_approval = true
    end
    
    if @article.save and @article.ad
      flash[:notice] = translate "Advertisement saved successfully."
      log_action("articles_create_ad", @article.id)
      redirect_to :back
      
    elsif @article.save
      if @article.translation_requested
        if current_user.english
          @article.translations.create(request: true, english: @article.title,
            field: "title", user_id: current_user.id)
          @article.translations.create(request: true, english: @article.body,
            field: "body", user_id: current_user.id)
        else
          @article.translations.create(request: true, spanish: @article.title,
            field: "title", user_id: current_user.id)
          @article.translations.create(request: true, spanish: @article.body,
            field: "body", user_id: current_user.id)
        end
      end

      Hashtag.extract(@article)
      current_user.notify_mentioned(@article)
      log_action("articles_create", @article.id)
      
      if @article.tab_id
        flash[:notice] = translate "Tab article successfully published."
        redirect_to tab_path(@article.tab_id)
      else
        flash[:notice] = translate "Article successfully published."
        redirect_to root_url
      end
      
    else
      flash[:error] = translate "Invalid input"
      log_action("articles_create_fail")
      redirect_to :back
    end
  end
  
  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      flash[:notice] = translate("Article successfully deleted.")
      log_action("articles_destroy")
    else
      flash[:error] = translate("Article could not be deleted.")
    end
    redirect_to :back
  end
end
