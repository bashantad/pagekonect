class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]
  layout "modal", :only => [:edit, :new]
  def index

    if params[:category].present?
      @events = Event.tagged_with params[:category], on: :category
    else
      @events = Event.uniq_users.collect{ |user| user.events.last }
    end
      
    @desc_length = 60
    @title_length = 40

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.new event_params
    @event.category_list.add(params[:event][:category]) if params[:event][:category].present?

    if @event.save
      redirect_to event_path(@event), notice: "Event created successfully."
    else
      render 'new', alert: "Error creating event."
    end
  end

  def update
     respond_to do |format|
       if @event.update(event_params)
         @event.update_category_list (params[:event][:category])
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
     @all_events = @event.user.events
   end
    
   private
   # Use callbacks to share common setup or constraints between actions.
   def set_event
     if params[:action] == "show"
       @event = Event.find(params[:id])
     else
       @event = current_user.events.find(params[:id])
     end
     @event.increment_views(request.remote_ip) if @event.present?
   end

    def event_params
      event_attributes = [:title, :description, :image, :image_description,  :is_searchable, :address, :event_date, :facebook_url, :url, :twitter_url, :start_time, :end_time, :is_suggestor, :category, :google_plus_url]
      parameters = params.require(:event).permit(event_attributes)
      parameters
    end
end