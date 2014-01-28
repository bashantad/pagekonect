class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @events = Event.all
    @desc_length = 60
    @title_length = 40   
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.new event_params

    if @event.save
      redirect_to event_path(@event), notice: "Event created successfully."
    else
      render 'new', alert: "Error creating event."
    end
  end

  def update
     respond_to do |format|
       if @event.update(event_params)
         format.html { redirect_to @event, notice: 'Event was successfully updated.' }
         format.json { head :no_content }
       else
         format.html { render action: 'edit' }
         format.json { render json: @event.errors, status: :unprocessable_entity }
       end
     end
   end

   def destroy
     @event.destroy
     respond_to do |format|
       format.html { redirect_to events_url, notice: 'Event was successfully deleted.' }
       format.json { head :no_content }
     end
   end

   def show
      
    end
    
   private
   # Use callbacks to share common setup or constraints between actions.
   def set_event
     @event = Event.find(params[:id])
     @event.increment_views(request.remote_ip) if @event.present?
   end

    def event_params
      event_attributes = [:title, :description, :image, :is_searchable, :address, :event_date]
      params.require(:event).permit(event_attributes)
    end
end