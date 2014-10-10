class NotesController < ApplicationController
  def notify
    @user = User.find(params[:id])
    @note = Note.new
  end
  
  def create
    @note = Note.new(params[:note].permit(:message))
    @note.user_id = params[:user_id]
    @note.sender_id = current_user.id
    @note.action = params[:note_action].to_s
    @note.item_id = 1
    
    if @note.save
      flash[:notice] = translate("The notification was sent.")
      redirect_to User.find(@note.user_id)
    else
      flash[:error] = translate("Invalid input.")
      redirect_to :back
    end
  end
  
  def index
    if current_user then
      @notes = current_user.notes.reverse.first 10
      @notes.each do |note|
        note.update checked: true
      end
    end
  end
  
  def clear
    @notes = current_user.notes
    @notes.each do |note|
      note.destroy!
    end
    redirect_to user_notes_path(current_user)
  end
end
