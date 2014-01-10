class Content < ActiveRecord::Base
  include Commentable
  
  acts_as_votable

  belongs_to :user
  has_attached_file :image, 
                    :styles => { :medium => "400x400>", :thumb => "132x132>" }, 
                    :url => "/assets/contents/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/contents/:id/:style/:basename.:extension",
                    :default_url => "/assets/missing.png"
end