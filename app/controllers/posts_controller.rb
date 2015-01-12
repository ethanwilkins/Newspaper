class PostsController < ApplicationController
  def finalize_sale
    @post = Post.find(params[:post_id])
    @folder = Folder.find(params[:folder_id])
    if @folder.notify_members(current_user, :sale_finalized) and @post.destroy
      flash[:notice] = translate("The sale was finalized successfully.")
      log_action("posts_finalize_sale")
      redirect_to root_url
    else
      flash[:error] = translate("The sale could not be finalized.")
      log_action("posts_finalize_sale_fail")
      redirect_to :back
    end
  end
  
  def up_vote
    @post = Post.find(params[:id])
    Vote.up_vote!(@post, current_user)
    Note.notify(current_user, User.find(@post.user_id), :like_post, @post.id)
    log_action("posts_up_vote", @post.id)
  end
  
  def un_vote
    @post = Post.find(params[:id])
    Vote.un_vote!(@post, current_user)
    log_action("posts_down_vote", @post.id)
  end

  def create
    @post = current_user.posts.new(params[:post].permit(:title, :body, :image,
      :translation_requested, :repopulation_interval, :sale))
    @post.subtab_id = params[:subtab_id]
    @post.tab_id = params[:tab_id]
    
    # for locale targeted content
    @post.zip_code = current_user.zip_code
    @post.ip = request.remote_ip.to_s
    @post.latitude = current_user.latitude
    @post.longitude = current_user.longitude
    
    if @post.expiration_date == Date.current
      @post.expiration_date = nil
    end
    
    if @post.save
      if @post.translation_requested
        if current_user.english
          @post.translations.create(request: true, english: @post.body,
            field: "body", user_id: current_user.id)
        else
          @post.translations.create(request: true, spanish: @post.body,
            field: "body", user_id: current_user.id)
        end
      end
      current_user.notify_mentioned(@post)
      Hashtag.extract(@post) if @post.body
      log_action("posts_create", @post.id)
      redirect_to :back
    else
      flash[:error] = translate "Invalid input"
      log_action("posts_create_fail")
      redirect_to :back
    end
  end
  
  def update
    @post = Post.find(params[:id])
    @post.translation_requested = params[:translation_requested]
    
    if @post.update(params[:post].permit(:body, :english_version))
      log_action("posts_update", @post.id)
      redirect_to @post
    else
      flash[:error] = translate "The post could not be updated."
      log_action("posts_update_fail")
      redirect_to :back
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    subtab_id = @post.subtab_id
    tab_id = @post.tab_id
    if @post.destroy
      flash[:notice] = translate("The post was successfully deleted.")
      log_action("posts_destroy")
      if tab_id
        redirect_to tab_path(tab_id)
      elsif subtab_id
        redirect_to tab_subtab_path(subtab_id)
      else
        redirect_to tabs_path
      end
    else
      flash[:error] = translate("The post could not be deleted.")
      log_action("posts_destroy_fail", @post.id)
      redirect_to :back
    end
  end
  
  def edit
    @post = Post.find(params[:id])
    log_action("posts_edit", @post.id)
  end
  
  def show
    @post = Post.find_by_id(params[:id])
    if @post
      @new_comment = Comment.new
      @comments = @post.comments
      log_action("posts_show", @post.id)
      save_search @post
    else
      log_action("posts_show_fail")
    end
  end
  
  def index
    Post.delete_expired
    Post.repopulate
    @advert = Article.local_advert(current_user)
    @posts = Post.all.reverse
    @post = Post.new
    @social = true
    log_action("posts_index")
  end
end
