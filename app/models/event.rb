class Event < Content
  validates_presence_of :title, :description, :event_date, :address
end