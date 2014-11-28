class EventsController < ApplicationController
  def approve
    @event = Event.find(params[:id])
    @event.update approved: true
    Note.notify(current_user, User.find(@event.user_id),
      :event_approved, @event.id)
    Activity.log_action(current_user, request.remote_ip.to_s, "events_approve", @event.id)
    redirect_to :back
  end

  def deny
    @event = Event.find(params[:id])
    @event.update approved: false
    Note.notify(current_user, User.find(@event.user_id),
      :event_denied, @event.id)
    Activity.log_action(current_user, request.remote_ip.to_s, "events_deny", @event.id)
    redirect_to :back
  end
  
  def pending
    @events = Event.pending.reverse
    Activity.log_action(current_user, request.remote_ip.to_s, "events_pending")
    render "events/index"
  end
  
  def index
    @events = Event.approved.reverse
    Event.remove_expired(@events)
    Activity.log_action(current_user, request.remote_ip.to_s, "events_index")
  end

  def new
    @event = Event.new
    Activity.log_action(current_user, request.remote_ip.to_s, "events_new")
  end
  
  def create
    @event = Event.new(params[:event].permit(:title, :body, :location, :date, :image,
      :english_title, :english_body, :translation_requested))
    @event.approved = true if current_user.admin
    @event.user_id = current_user.id
    
    if @event.save
      flash[:notice] = translate "Event submitted successfully."
      if current_user.admin
        redirect_to events_path
      else
        Activity.log_action(current_user, request.remote_ip.to_s, "events_create", @event.id)
        redirect_to root_url
      end
    else
      flash[:error] = translate "Invalid input"
      Activity.log_action(current_user, request.remote_ip.to_s, "events_create_fail")
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
    Activity.log_action(current_user, request.remote_ip.to_s, "events_show", @event.id)
  end
end
