class MessagesController < ApplicationController
  def create
    @folder = Folder.find(params[:folder_id])
    @message = @folder.messages.new(params[:message].permit(:text))
    @message.user_id = current_user.id
    
    if @message.save
      @folder.notify_members(current_user, params[:message_type].to_sym)
      @folder.update updated_at: Time.now
      redirect_to @folder
    else
      flash[:error] = translate "Message did not send"
      redirect_to :back
    end
  end
end