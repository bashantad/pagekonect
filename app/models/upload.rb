class Upload < ActiveRecord::Base
  include Commentable
  include Viewable
  include ShareCountable
  include PgSearch

  acts_as_votable
  multisearchable :against => [:photo_tag, :photo_description]

  belongs_to :user
  validates :photo, :presence => true
  has_attached_file :photo, 
                    :styles => {:thumb => "212x212>" }, 
                    :url => "/users/uploads/:id/:style/:basename.:extension",
                    :path => "users/uploads/:id/:style/:basename.:extension",
                    :default_url => "/assets/missing.png"
    
  include Rails.application.routes.url_helpers
  
  def title
    photo_tag.present? ? photo_tag : photo_description
  end
  
  def to_jq_upload
      {
        "name" => read_attribute(:photo_file_name),
        "size" => read_attribute(:photo_file_size),
        "url" => photo.url(:original),
        "thumbnail_url" => photo.url(:thumb),
        "delete_url" => upload_path(self),
        "delete_type" => "DELETE" 
      }
  end
  
  def self.uniq_users
    self.all.order("created_at desc").collect(&:user).uniq
  end
end
