class LocalAdsController < ApplicationController
   before_filter :authenticate_user!
   before_action :check_account_completeness
   before_action :set_local_ads, only: [:show, :edit, :update, :destroy, :detail]
   layout "modal", :only => [:edit, :new]
  def new
    @local_ad = LocalAd.new
  end

  def create
    @local_ad = current_user.local_ads.new(local_ads_params)
    @local_ad.category_list.add(categories)
    if @local_ad.save
      redirect_to local_ads_path,  notice: "Ad was created successfully."
    else
      render(:action => :new)
    end
  end

  def index
    if params[:category].present? && params[:category] != "All"
      @local_ads = LocalAd.tagged_with params[:category], on: :category
    elsif params[:location].present?
      address = "%#{params[:location].downcase}%"
      @local_ads = LocalAd.where("address LIKE '#{address}'")
    else
      @local_ads = LocalAd.all.select{|local_ad| local_ad.user.from_same_region?(current_user)}
    end
    @desc_length = 60
    @title_length = 40
    @local_ads = LocalAd.find_uniq_values(@local_ads)
    @users = User.all.select{|user| user.from_same_region?(current_user)}
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @all_local_ads = @local_ad.user.local_ads
  end

  def update
    respond_to do |format|
      if @local_ad.update(local_ads_params)
        @local_ad.update_category_list (categories)
        format.html { redirect_to @local_ad, notice: 'Ad was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @local_ad.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @local_ad.destroy
    respond_to do |format|
      format.html { redirect_to local_ads_url, notice: 'Ad was successfully deleted' }
      format.json { head :no_content }
    end
  end

  private

  def categories
    params[:local_ad][:category]
  end

  def local_ads_params
    permitted_params = [
      :image,
      :image_description,
      :title,
      :description,
      :is_suggestor,
      :commentable,
      :url,
      :facebook_url,
      :twitter_url,
      :google_plus_url
    ]
    params.require(:local_ad).permit(permitted_params)
  end

  def check_account_completeness
    if !current_user.account_details_present?    
      flash[:alert] = "Please complete your account details from <a href='/users/edit'>Edit your account</a> section before you can create or view local ads".html_safe
      redirect_to root_path
    end
  end

  def set_local_ads
    if params[:action] == "show"
      @local_ad = LocalAd.find(params[:id])
    else
      @local_ad = current_user.local_ads.find(params[:id])
    end
    @local_ad.increment_views(request.remote_ip) if @local_ad.present?
  end
end