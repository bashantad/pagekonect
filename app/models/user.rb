class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_attached_file :avatar, 
                    :styles => { :medium => "400x400>", :thumb => "132x132>" }, 
                    :url => "/assets/users/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/users/:id/:style/:basename.:extension",
                    :default_url => "/assets/missing.png"
 has_attached_file :banner_image,
                    :url => "/assets/users/banner/:id/:basename.:extension",
                    :path => ":rails_root/public/assets/users/banner/:id/:basename.:extension",
                    :default_url => "/assets/default.png"
end 
