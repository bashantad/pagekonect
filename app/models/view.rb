class View < ActiveRecord::Base
  belongs_to :viewable, polymorphic: true
  validates :ip_address, :presence => true
  validates_presence_of :viewable_type, :viewable_id
end
