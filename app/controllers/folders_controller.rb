class FoldersController < ApplicationController
  def new
    @receiver = User.find_by_id(params[:user_id])
    @sales_post = Post.find_by_id(params[:post_id])
    @folder = Folder.new
  end
  
  def create
    @folder = Folder.new(params[:folder])
    @folder.post_id = params[:post_id]
    @receiver = User.find(params[:user_id])
    
    if @folder.save
      # adds sender and receiver to folder as members
      @folder.members.create(user_id: current_user.id)
      @folder.members.create(user_id: @receiver.id)
      # creates the first message sent by sender
      @message = @folder.messages.create(text: params[:text], user_id: current_user.id)
      # notifies the receiver about the message
      Note.notify(current_user, @receiver, (params[:post_id] ? :sales_inquiry : :message), @folder.id)
      # redirects to the new folder
      redirect_to @folder
    else
      flash[:error] = "Invalid input"
      redirect_to :back
    end
  end

  def show
    @folder = Folder.find_by_id(params[:id])
    if @folder
      @sales_post = @folder.post
      @message = Message.new
      @messages = @folder.messages
      Message.where("user_id != ?", current_user.id).update_all seen: true
      @messages = @messages.last(5)
    end
  end
  
  def index
    reset_page
    @folders = Folder.inbox_of(current_user).reverse.
      # drops first several posts if :feed_page
      drop((session[:page] ? session[:page] : 0) * page_size).
      # only shows first several posts of resulting array
      first(page_size)
  end
end
