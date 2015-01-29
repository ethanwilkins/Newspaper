class EventsController < ApplicationController
  def attendance
    @event = Event.find(params[:event_id])
  end
  
  def going
    @event = Event.find(params[:event_id])
    invited_user = @event.members.find_by_user_id(current_user.id) if @event
    if invited_user and invited_user.update(status: :going)
      @event.user.notify current_user, :going, @event.id
      flash[:notice] = translate("RSVP saved successfully.")
    else
      flash[:error] = translate("RSVP failed.")
    end
    redirect_to :back
  end
  
  def not_going
    @event = Event.find(params[:event_id])
    invited_user = @event.members.find_by_user_id(current_user.id) if @event
    invited_user.update(status: :not_going) if invited_user
    redirect_to :back
  end
  
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
    if params[:subtab_id]
      @subtab = Subtab.find_by_id(params[:subtab_id])
    elsif params[:tab_id]
      @tab = Tab.find_by_id(params[:tab_id])
    end
    log_action("events_new")
  end
  
  def create
    @event = Event.new(params[:event].permit(:title, :body, :location, :date, :image, :translation_requested))
    @event.zip_code = current_user.zip_code
    @event.user_id = current_user.id
    @event.tab_id = params[:tab_id]
    # auto-approved for the privileged or for tab events
    @event.approved = true if privileged? or @event.tab_id
    
    if @event.save
      if @event.translation_requested
        if current_user.english
          @event.translations.create(request: true, english: @event.title,
            field: "title", user_id: current_user.id)
          @event.translations.create(request: true, english: @event.body,
            field: "body", user_id: current_user.id)
        else
          @event.translations.create(request: true, spanish: @event.title,
            field: "title", user_id: current_user.id)
          @event.translations.create(request: true, spanish: @event.body,
            field: "body", user_id: current_user.id)
        end
      end
      
      current_user.notify_mentioned(@event)
      Hashtag.extract(@event) if @event.body
      @event.invite_users(params[:invited_users])
      
      flash[:notice] = translate "Event submitted successfully."
      if @event.tab_id
        redirect_to tab_path(@event.tab_id)
      elsif privileged?
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
    save_search @event
    log_action("events_show", @event.id)
  end
end
