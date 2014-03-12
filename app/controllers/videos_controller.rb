class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]
  layout "modal", :only => [:edit, :new]
  def index
    if params[:category].present? && params[:category] != "All"
      @all_videos = Video.tagged_with params[:category], on: :category
    else
      @all_videos = Video.all
    end
    @videos = Video.find_uniq_values(@all_videos)
    @desc_length = 60
    @title_length = 40
    @iframe_width = 230
    @iframe_height = 150
  end

  def show

  end

  def new
    @video = Video.new    
  end

  def edit
  end
  
  def show
    @all_videos = @video.user.videos
  end
  
  def create
    @video = current_user.videos.new(video_params)
    @video.category_list.add(params[:video][:category]) if params[:video][:category].present?
    if @video.save
      flash[:notice] = 'video was successfully posted.' 
    else
      render action: 'new'
    end
    @desc_length = 60
    @title_length = 40
    @iframe_width = 230
    @iframe_height = 150
  end

  def update
    respond_to do |format|
      if @video.update(video_params)
        @video.update_category_list (params[:video][:category])
        format.html { redirect_to @video, notice: 'video was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: 'video was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_video
    if params[:action] == "show"
      @video = Video.find(params[:id])
    else
      @video = current_user.videos.find(params[:id])
    end
    @video.increment_views(request.remote_ip) if @video.present?
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def video_params
    params.require(:video).permit(:title, :description, :url, :facebook_url, :twitter_url, :google_plus_url, :is_searchable)
  end
end