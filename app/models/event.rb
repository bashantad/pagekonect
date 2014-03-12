class Event < Content
  validates_presence_of :description, :address
end