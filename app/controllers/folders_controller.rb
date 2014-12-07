class FoldersController < ApplicationController
  def index
    unless session[:more]
      session[:page] = nil
    end
    session[:more] = nil
    
    @folders = Folder.inbox_of(current_user).reverse.
        # drops first several posts if :feed_page
        drop((session[:page] ? session[:page] : 0) * page_size).
        # only shows first several posts of resulting array
        first(page_size)
  end
  
  def new
    session[:receiver] = params[:user_id]
    @folder = Folder.new
  end

  def show
    @folder = Folder.find(params[:id])
    @message = Message.new
    @messages = @folder.messages
    Message.where("user_id != ?", current_user.id).update_all seen: true
    @messages = @messages.last(5)
  end
  
  def create
    @folder = Folder.new(params[:folder])
    @receiver = User.find(session[:receiver])
    
    if @folder.save
      # adds sender and receiver to folder as members
      @folder.members.create(user_id: current_user.id)
      @folder.members.create(user_id: @receiver.id)
      # creates the first message sent by sender
      @message = @folder.messages.create(text: params[:text], user_id: current_user.id)
      # notifies the receiver about the message
      # @receiver.notify!(:message, current_user, @folder.id)
      # redirects to the new folder
      redirect_to @folder
    else
      flash[:error] = "Invalid input"
      redirect_to :back
    end
  end
end
