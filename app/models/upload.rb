class Upload < ActiveRecord::Base
  include Commentable
  include Viewable
  include PgSearch

  acts_as_votable
  multisearchable :against => [:photo_tag, :photo_description]

  belongs_to :user
  validates :photo, :presence => true
  has_attached_file :photo, 
                    :styles => {:thumb => "132x132>" }, 
                    :url => "/users/uploads/:id/:style/:basename.:extension",
                    :path => "users/uploads/:id/:style/:basename.:extension",
                    :default_url => "/assets/missing.png"
    
  include Rails.application.routes.url_helpers
  
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
end
