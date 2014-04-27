class City < ActiveRecord::Base
  belongs_to :state
  validates :name, :state, :presence => true
  validates :name, uniqueness: { scope: :state, message: "should be unique for a state" }
end
