class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy, :detail]
  before_filter :authenticate_user!, except: [:index, :show, :detail]

  def index
    @videos = Video.all.order("id desc")
    @desc_length = 60
    @title_length = 40
    @iframe_width = 260
    @iframe_height = 180
  end

  def show

  end

  def new
    @video = Video.new    
  end

  def edit
  end

  def detail

  end

  def create
    @video = current_user.videos.new(video_params)
    respond_to do |format|
      if @video.save
        format.html { redirect_to videos_path, notice: 'video was successfully posted.' }
        format.json { render action: 'show', status: :created, location: @video }
      else
        format.html { render action: 'new' }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @video.update(video_params)
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
    @video = Video.find(params[:id])
    @vid_info = VideoInfo.new(@video.url)
    @video.increment_views(request.remote_ip) if @video.present?
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def video_params
    params.require(:video).permit(:title, :description, :url, :is_searchable)
  end
end