class Event < Content
  validates_presence_of :title, :description
end