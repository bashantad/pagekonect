class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  acts_as_voter
  acts_as_tagger
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :full_name, :email, :presence => true
  has_many :news
  has_many :uploads
  has_many :videos
  has_many :events
  has_many :deals
  has_many :comments
  has_attached_file :avatar, 
                    :styles => { :medium => "400x400>", :thumb => "132x132>" }, 
                    :url => "/users/avatar/:id/:style/:basename.:extension",
                    :path => "/users/avatar/:id/:style/:basename.:extension",
                    :default_url => "/assets/missing.png"
  has_attached_file :banner_image, :processors => [:cropper],
                    :url => "/users/banner/:id/:basename.:extension",
                    :path => "/users/banner/:id/:basename.:extension",
                    :default_url => "/assets/default.png"
                    
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :coming_action
  after_update :reprocess_banner, :if => :cropping?
  
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def avatar_geometry(style = :original)
    @geometry ||= {}
    banner_image_path = (banner_image.options[:storage] == :s3) ? banner_image.url(style) : banner_image.path(style)
    @geometry[style] ||= Paperclip::Geometry.from_file(banner_image_path)
  end

  def full_address
    ['street', 'city', 'state', 'zip', 'country'].collect { |s| self[s].nil? ? '' : self[s] }.join ' '
  end

  private

  def reprocess_banner
    banner_image.assign(banner_image)
    banner_image.save
  end
end 
