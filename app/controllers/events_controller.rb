class EventsController < ApplicationController
  def approve
    @event = Event.find(params[:id])
    @event.update approved: true
    Note.notify(current_user, User.find(@event.user_id),
      :event_approved, @event.id)
    redirect_to :back
  end

  def deny
    @event = Event.find(params[:id])
    @event.update approved: false
    Note.notify(current_user, User.find(@event.user_id),
      :event_denied, @event.id)
    redirect_to :back
  end
  
  def pending
    @events = Event.pending.reverse
    render "events/index"
  end
  
  def index
    @events = Event.approved.reverse
    Event.remove_expired(@events)
  end

  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(params[:event].permit(:title, :body, :location, :date))
    @event.user_id = current_user.id
    
    if @event.save
      flash[:notice] = "Event submitted successfully."
      redirect_to root_url
    else
      flash[:error] = "Invalid input"
      redirect_to :back
    end
  end
  
  def show
    @event = Event.find(params[:id])
  end
end
