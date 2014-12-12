class PostsController < ApplicationController
  def finalize_sale
    @post = Post.find(params[:post_id])
    @folder = Folder.find(params[:folder_id])
    if @folder.notify_members(current_user, :sale_finalized) and @post.destroy
      flash[:notice] = translate("The sale was finalized successfully.")
      Activity.log_action(current_user, request.remote_ip.to_s, "posts_finalize_sale")
      redirect_to root_url
    else
      flash[:error] = translate("The sale could not be finalized.")
      Activity.log_action(current_user, request.remote_ip.to_s, "posts_finalize_sale_fail")
      redirect_to :back
    end
  end
  
  def up_vote
    @post = Post.find(params[:id])
    Vote.up_vote!(@post, current_user)
    Note.notify(current_user, User.find(@post.user_id), :like_post, @post.id)
    Activity.log_action(current_user, request.remote_ip.to_s, "posts_up_vote", @post.id)
    redirect_to :back
  end
  
  def un_vote
    @post = Post.find(params[:id])
    Vote.un_vote!(@post, current_user)
    Activity.log_action(current_user, request.remote_ip.to_s, "posts_down_vote", @post.id)
    redirect_to :back
  end

  def create
    @post = current_user.posts.new(params[:post].permit(:title, :body, :image,
      :translation_requested, :expiration_date, :repopulation_interval, :sale))
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
          @post.translations.create(request: true, english: @post.body, field: "body")
        else
          @post.translations.create(request: true, spanish: @post.body, field: "body")
        end
      end
      
      Hashtag.extract(@post) if @post.body
      Activity.log_action(current_user, request.remote_ip.to_s, "posts_create", @post.id)
      redirect_to :back
    else
      flash[:error] = translate "Invalid input"
      Activity.log_action(current_user, request.remote_ip.to_s, "posts_create_fail")
      redirect_to :back
    end
  end
  
  def update
    @post = Post.find(params[:id])
    @post.translation_requested = params[:translation_requested]
    
    if @post.update(params[:post].permit(:body, :english_version))
      Activity.log_action(current_user, request.remote_ip.to_s, "posts_update", @post.id)
      redirect_to @post
    else
      flash[:error] = translate "The post could not be updated."
      Activity.log_action(current_user, request.remote_ip.to_s, "posts_update_fail")
      redirect_to :back
    end
  end
  
  def edit
    @post = Post.find(params[:id])
    Activity.log_action(current_user, request.remote_ip.to_s, "posts_edit", @post.id)
  end
  
  def show
    @post = Post.find_by_id(params[:id])
    if @post
      @new_comment = Comment.new
      @comments = @post.comments.reverse
      Activity.log_action(current_user, request.remote_ip.to_s, "posts_show", @post.id)
    else
      Activity.log_action(current_user, request.remote_ip.to_s, "posts_show_fail")
    end
  end
  
  def index
    Post.delete_expired
    Post.repopulate
    @advert = Article.local_advert(current_user)
    @posts = Post.all.reverse
    @post = Post.new
    @social = true
    Activity.log_action(current_user, request.remote_ip.to_s, "posts_index")
  end
end
