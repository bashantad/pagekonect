class Content < ActiveRecord::Base
  include Commentable
  include Viewable
  include PgSearch
  
  acts_as_votable
  multisearchable :against => [:title, :description, :image_file_name, :image_description], :if => :is_searchable?

  belongs_to :user
  validates :title, :presence => true
  has_attached_file :image, :styles => { :medium => "350x350>", :thumb => "145x145>" }, 
      :url => "/contents/:class/:id/:style/:basename.:extension",
      :path => "/contents/:class/:id/:style/:basename.:extension",
      :default_url => "/assets/news.png"
  def is_news?
    self.instance_of? News
  end

  def is_video?
    self.instance_of? Video
  end
  
  def is_event?
    self.instance_of? Event
  end
  
  def get_default_url
    if self.is_news?
      "/assets/news.png"
    elsif self.is_video?
      "/assets/videos.png"
    else
      "/assets/event.png"
    end
  end

  def is_content?
    true
  end
end

