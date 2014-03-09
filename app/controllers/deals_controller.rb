class DealsController < ApplicationController
  before_action :set_deal, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]
  layout "modal", :only => [:edit, :new]

  def index
    if params[:category].present? && params[:category] != "All"
      @deals = Deal.tagged_with params[:category], on: :category
    else
      @deals = Deal.uniq_users.collect{ |user| user.deals.last}
    end
    
    @desc_length = 60
    @title_length = 40   
  end

  def new
    @deal = Deal.new
  end
  
  def deals
  
  end
  
  def edit
    
  end

  def create
    @deal = current_user.deals.new deal_params
    @deal.category_list.add(params[:deal][:category]) if params[:deal][:category].present?

    if @deal.save
      redirect_to deal_path(@deal), notice: "Deal created successfully."
    else
      render 'new', alert: "Error creating Deal."
    end
  end

  def update
     respond_to do |format|
       if @deal.update(deal_params)
         @deal.update_category_list (params[:deal][:category])
         format.html { redirect_to @deal, notice: 'Deal was successfully updated.' }
         format.json { head :no_content }
       else
         format.html { render action: 'edit' }
         format.json { render json: @deal.errors, status: :unprocessable_entity, :alert => "error" }
       end
     end
   end

   def destroy
     @deal.destroy
     respond_to do |format|
       format.html { redirect_to deals_url, notice: 'Deal was successfully deleted.' }
       format.json { head :no_content }
     end
   end

   def show
      @all_deals = @deal.user.deals
    end
    
   private
   # Use callbacks to share common setup or constraints between actions.
   def set_deal
     if params[:action] == "show"
       @deal = Deal.find(params[:id])
     else
       @deal = current_user.deals.find(params[:id])
     end
     @deal.increment_views(request.remote_ip) if @deal.present?
   end
   
  def deal_params
    deal_attributes = [:title, :description, :image, :image_description, :is_searchable, :address, :facebook_url, :twitter_url, :google_plus_url, :url, :start_time, :end_time, :old_price, :new_price, :is_suggestor, :event_date]
    parameters = params.require(:deal).permit(deal_attributes)
    parameters
  end
end