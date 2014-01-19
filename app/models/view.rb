class View < ActiveRecord::Base
  belongs_to :content
  validates :content_id, :ip_address, :presence => true
  # attr_accessible :ip_address
end
