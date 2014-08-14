class EventsController < ApplicationController
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(params[:event].permit(:title, :body, :location, :date))
    
    if @event.save
      redirect_to :back
    else
      flash[:error] = "Invalid input"
      redirect_to :back
    end
  end
  
  def index
    @events = Event.all.reverse
  end
end
