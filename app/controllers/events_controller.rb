class EventsController < ApplicationController
  def approve
    if privileged?
      @event = Event.find(params[:id])
      @event.update approved: true
      Note.notify(current_user, User.find(@event.user_id),
        :event_approved, @event.id)
      log_action("events_approve", @event.id)
    end
    redirect_to :back
  end

  def deny
    if privileged?
      @event = Event.find(params[:id])
      @event.update approved: false
      Note.notify(current_user, User.find(@event.user_id),
        :event_denied, @event.id)
      log_action("events_deny", @event.id)
    end
    redirect_to :back
  end
  
  def pending
    if master? and session[:group_id]
      zips = []
      Group.find(session[:group_id]).zips.each { |zip| zips << zip.zip_code }
      @events = Event.where(zip_code: zips).pending.reverse
    elsif master?
      @events = Event.pending.reverse
    elsif admin?
      zips = []
      current_user.group.zips.each { |zip| zips << zip.zip_code }
      @events = Event.where(zip_code: zips).pending.reverse
    end
    log_action("events_pending")
    render "events/index"
  end
  
  def index
    @events = Event.approved.reverse
    Event.remove_expired(@events)
    log_action("events_index")
  end

  def new
    @event = Event.new
    log_action("events_new")
  end
  
  def create
    @event = Event.new(params[:event].permit(:title, :body, :location, :date, :image, :translation_requested))
    @event.approved = true if privileged? # automatically approved for the privileged
    @event.zip_code = current_user.zip_code
    @event.user_id = current_user.id
    
    if @event.save
      if @event.translation_requested
        if current_user.english
          @event.translations.create(request: true, english: @event.title, field: "title")
          @event.translations.create(request: true, english: @event.body, field: "body")
        else
          @event.translations.create(request: true, spanish: @event.title, field: "title")
          @event.translations.create(request: true, spanish: @event.body, field: "body")
        end
      end

      Hashtag.extract(@event) if @event.body
      
      flash[:notice] = translate "Event submitted successfully."
      if privileged?
        redirect_to events_path
      else
        log_action("events_create", @event.id)
        redirect_to root_url
      end
    else
      flash[:error] = translate "Invalid input"
      log_action("events_create_fail")
      redirect_to :back
    end
  end
  
  def update
    @event = Event.find(params[:id])
    if @event.update(params[:event].permit(:title, :body, :location, :date, :image,
      :english_title, :english_body, :translation_requested))
      flash[:notice] = translate("Event updated successfully.")
    else
      flash[:error] = translate("Event failed to update.")
    end
    redirect_to :back
  end
  
  def show
    @event = Event.find(params[:id])
    @comments = @event.comments
    @new_comment = Comment.new
    log_action("events_show", @event.id)
  end
end
