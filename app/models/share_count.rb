class ShareCount < ActiveRecord::Base
  belongs_to :share_countable, polymorphic: true 
  validates_presence_of :share_countable_type, :share_countable_id
end
