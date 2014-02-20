class NewsController < ApplicationController
  before_action :set_news, only: [:show, :edit, :update, :destroy, :detail]

  before_filter :authenticate_user!, except: [:index, :show, :detail]

  def index
    @news = News.uniq_users.collect{ |user| user.news.last } 
    @desc_length = 100
    @title_length = 83
  end

  def show
    @all_news = @news.user.news
  end

  def new
    @news = News.new
  end

  def edit
  end
  
  def detail
    
  end
  
  def create
    @news = current_user.news.new(news_params)
    respond_to do |format|
      if @news.save
        format.html { redirect_to news_index_path, notice: 'news was successfully created.' }
        format.json { render action: 'show', status: :created, location: @news }
      else
        format.html { render action: 'new' }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @news.update(news_params)
        format.html { redirect_to @news, notice: 'news was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @news.destroy
    respond_to do |format|
      format.html { redirect_to news_url, notice: 'news was successfully deleted' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news
      if params[:action] == "show"
        @news = News.find(params[:id])
      else
        @news = current_user.news.find(params[:id])
      end
      @news.increment_views(request.remote_ip) if @news.present?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_params
      params.require(:news).permit(:title, :description, :image, :image_description, :url, :is_searchable, :facebook_url, :twitter_url)
    end
end
