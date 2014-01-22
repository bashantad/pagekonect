class EventsController < ApplicationController
  def index
    
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new event_params

    if @event.save
      redirect_to event_path(@event), notice: "Event created successfully."
    else
      render 'new', alert: "Error creating event."
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  private
    def event_params
      params[:event][:location] = "POINT (#{params[:event][:longitude]} #{params[:event][:latitude]})"
      event_attributes = [:title, :description, :location]
      params.require(:event).permit(event_attributes)
    end
end