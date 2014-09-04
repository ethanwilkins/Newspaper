class NotesController < ApplicationController
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
