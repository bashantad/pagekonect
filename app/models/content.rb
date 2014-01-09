class Content < ActiveRecord::Base
  include PageKonect::Commentable
  
  acts_as_votable

  has_attached_file :thumbnail, 
                    :styles => { :medium => "400x400>", :thumb => "132x132>" }, 
                    :url => "/assets/contents/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/contents/:id/:style/:basename.:extension",
                    :default_url => "/assets/missing.png"
end
