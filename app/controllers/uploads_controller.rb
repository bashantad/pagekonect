class UploadsController < ApplicationController
  before_action :set_upload, only: [:edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]
  # GET /uploads
  # GET /uploads.json
  def index
    @uploads = current_user.uploads.order("created_at desc")
    @upload = Upload.new
    respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @uploads.map{|upload| upload.to_jq_upload } }
    end
  end
  
  def preview
    @uploads = current_user.uploads.order("created_at desc")
  end
  
  def publish
    @uploads = Upload.all.order("created_at desc")
    @title_length = 83
  end

  # GET /uploads/1
  # GET /uploads/1.json
  def show
    @upload = Upload.find(params[:id])
    @upload.increment_views(request.remote_ip) if @upload.present?
  end

  # GET /uploads/new
  def new
    @upload = current_user.uploads.new
  end

  # GET /uploads/1/edit
  def edit
  end

  # POST /uploads
  # POST /uploads.json
  def create
    @upload = current_user.uploads.new(upload_params)
    respond_to do |format|
      if @upload.save
        format.html {
          render :json => [@upload.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json { render json: {files: [@upload.to_jq_upload]}, status: :created, location: @upload }
      else
        format.html { render action: "new" }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /uploads/1
  # PATCH/PUT /uploads/1.json
  def update
    @upload.update(params[:name] => params[:value])
    respond_to do |format|
      format.json { render json: nil, status: :ok }
    end
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.json
  def destroy
    @upload.destroy
    respond_to do |format|
      format.html { redirect_to uploads_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_upload
      @upload = current_user.uploads.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def upload_params
      params.require(:upload).permit(:photo_tag, :photo_description, :photo)
    end
end
