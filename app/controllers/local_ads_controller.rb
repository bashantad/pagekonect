class LocalAdsController < ApplicationController
   before_filter :authenticate_user!
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
      @local_ads = LocalAd.all
    end
    @desc_length = 60
    @title_length = 40

    respond_to do |format|
      format.html
      format.js
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
      :address,
      :is_suggestor,
      :commentable,
      :url,
      :facebook_url,
      :twitter_url,
      :google_plus_url
    ]
    params.require(:local_ad).permit(permitted_params)
  end
end