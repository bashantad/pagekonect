class Content < ActiveRecord::Base
  include Commentable
  include Viewable
  include ShareCountable
  include PgSearch

  CATEGORIES = ["Animals", "Beautician", "Beauty", "Building material", "Camping", "Cars", "Clothing", "Cuttery", "Fishing", "Food", "Handbag", "Holiday resorts", "Holidays", "Jewellery", "Kitchen appliance", "Makeup", "Makeup artist", "Pets", "Realstate", "Resorts", "Restaurant", "Shoes", "Shopping", "Sports", "Supermarket", "T.V", "Takeaway", "Tools", "Toys"]
  
  acts_as_votable
  acts_as_taggable_on "category"
  
  multisearchable :against => [:title, :description, :image_file_name, :image_description, :address]
  
  belongs_to :user
  validates :title, :presence => true
  has_attached_file :image, :styles => { :medium => "600x450>", :thumb => "212x212>" }, 
      :url => "/contents/:class/:id/:style/:basename.:extension",
      :path => "/contents/:class/:id/:style/:basename.:extension",
      :default_url => "/assets/news.png"
  
  validate :validate_start_date
  
  def validate_start_date
    return true unless self.class.to_s == "Event" || self.class.to_s == "Deal"
    self.errors.add(:event_date, "can't be blank") if self.start_time.present? && self.end_time.present? && self.event_date.blank?
  end
  
  def is_news?
    self.instance_of? News
  end

  def is_video?
    self.instance_of? Video
  end
  
  def is_event?
    self.instance_of? Event
  end
  
  def is_deal?
    self.instance_of? Deal
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
  
  def update_category_list(list)
    self.category_list.collect{|tag| self.category_list.remove(tag)}
    self.category_list.add list
    self.save
  end
  
  def self.find_uniq_values(contents)
    users = contents.collect{|content| content.user}.uniq
    uniq_contents = Hash.new
    contents.each do |content|
      uniq_contents[content.user.id] = content
    end
    uniq_contents.values.sort{|a,b| b.created_at <=> a.created_at}
  end

  def is_content?
    true
  end
end

