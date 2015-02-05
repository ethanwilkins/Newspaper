class MessagesController < ApplicationController
  def new_messages
    if current_user and params[:folder_id]
      @folder = Folder.find_by_id(params[:folder_id])
      @instant_messages = @folder.unread_messages.where.
        not(user_id: current_user.id) if @folder
    end
  end
  
  def create
    @folder = Folder.find(params[:folder_id])
    @message = @folder.messages.new(params[:message].permit(:text))
    @message.user_id = current_user.id
    
    if @message.save
      @folder.notify_members(current_user, params[:message_type].to_sym)
      @folder.update updated_at: Time.now
      log_action("messages_create", @message.id)
      redirect_to @folder
    else
      flash[:error] = translate "Message did not send"
      log_action("messages_create_fail")
      redirect_to :back
    end
  end
end
