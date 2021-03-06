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
  has_many :local_ads
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

  def is_admin?
    self.is_admin
  end

  def account_details_present?
    self.street.present? && self.city.present? && self.sub_region.present? && self.country.present? && self.state.present? && self.suburb.present?
  end

  def from_same_region?(current_user)
    return false unless self.account_details_present?
    return true if self.zip.downcase == current_user.zip.downcase
    self.sub_region == current_user.sub_region && (self == current_user || self.suburb.downcase == current_user.suburb.downcase || self.street.downcase == current_user.street || self.city.downcase == current_user.city.downcase)
  end

  def avatar_geometry(style = :original)
    @geometry ||= {}
    banner_image_path = (banner_image.options[:storage] == :s3) ? banner_image.url(style) : banner_image.path(style)
    @geometry[style] ||= Paperclip::Geometry.from_file(banner_image_path)
  end

  def full_address
    ['street', 'city', 'state', 'zip', 'country'].collect { |s| self[s].nil? ? '' : self[s] }.join ' '
  end

  def find_local_users
    return [self] if User.all.select{|u| u.full_address.strip.present? }.size == 0
    User.where("street=? OR city = ? OR zip = ? OR country = ?", self.street, self.city, self.zip, self.country)
  end

  private

  def reprocess_banner
    banner_image.assign(banner_image)
    banner_image.save
  end
end 
