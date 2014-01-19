class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  attr_accessible :description, :commentable_id, :commentable_type, :user_id 
end
