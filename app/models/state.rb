class State < ActiveRecord::Base
	validates :state, :country, :presence => true
	validates :state, uniqueness: { scope: :country, message: "should be unique for a country" }
	has_many :cities
end
