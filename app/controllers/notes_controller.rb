class NotesController < ApplicationController
  def select
    if master? and session[:group_id]
      zips = []
      Group.find(session[:group_id]).zips.each { |zip| zips << zip.zip_code }
      @notes = Note.where(zip_code: zips).where(action: :admin_message).reverse
      @users = User.where zip_code: zips
    elsif master?
      @users = User.all.sort_by &:name
      @notes = Note.all.reverse
    elsif admin?
      zips = []
      current_user.group.zips.each { |zip| zips << zip.zip_code }
      @notes = Note.where(zip_code: zips).where(action: :admin_message).reverse
      @users = User.where zip_code: zips
    end
    bundle = params[:"/notes/select"]
    user_id = bundle[:user_id] if bundle
    if user_id.present?
      @user = User.find(params[:"/notes/select"][:user_id])
      @note = Note.new(user_id: @user.id)
    end
  end
  
  def new
    @user = User.find(params[:id])
    @note = Note.new
    Activity.log_action(current_user, request.remote_ip.to_s, "notes_new")
  end
  
  def create
    @user = User.find(params[:user_id])
    @note = @user.notes.new(params[:note].permit(:message, :url))
    @note.sender_id = current_user.id
    @note.action = params[:note_action].to_s
    @note.zip_code = @user.zip_code
    @note.item_id = 1
    
    if @note.save
      flash[:notice] = translate("The notification was sent.")
      Activity.log_action(current_user, request.remote_ip.to_s, "notes_create", @note.id)
      redirect_to User.find(@note.user_id)
    elsif @note.errors.include? :invalid_url
      flash[:error] = translate(@note.errors[:invalid_url].first)
      redirect_to :back
    else
      flash[:error] = translate("Invalid input.")
      Activity.log_action(current_user, request.remote_ip.to_s, "notes_create_fail")
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
    @advert = Article.local_advert(current_user)
    Activity.log_action(current_user, request.remote_ip.to_s, "notes_index")
  end
  
  def clear
    @notes = current_user.notes
    @notes.each do |note|
      note.destroy!
    end
    Activity.log_action(current_user, request.remote_ip.to_s, "notes_clear")
    redirect_to user_notes_path(current_user)
  end
end
