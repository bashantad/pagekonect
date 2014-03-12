class NewsController < ApplicationController
  before_action :set_news, only: [:show, :edit, :update, :destroy, :detail]
  before_filter :authenticate_user!, except: [:index, :show, :detail]
  layout "modal", :only => [:edit, :new]
  
  def index
    if params[:category].present? && params[:category] != "All"
      @all_news = News.tagged_with params[:category], on: :category
    else
      @all_news = News.all 
    end
    @news = News.find_uniq_values(@all_news)

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
    @news.category_list.add(params[:news][:category]) if params[:news][:category].present?
    if @news.save
      flash[:notice] ='news was successfully created.'
    else
      render action: 'new'
    end
    @desc_length = 60
    @title_length = 40
  end

  def update
    respond_to do |format|
      if @news.update(news_params)
        @news.update_category_list (params[:news][:category])
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
      params.require(:news).permit(:title, :description, :image, :image_description, :url, :is_searchable, :facebook_url, :twitter_url, :google_plus_url)
    end
end
