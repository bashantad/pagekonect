class Event < Content
  validates_presence_of :description, :event_date, :address
end