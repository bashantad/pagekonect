class Event < Content

  acts_as_taggable_on "category"

  validates_presence_of :title, :description, :event_date, :address

  CATEGORIES = [
    "Music",
    "Conference",
    "Festivals",
    "Fundraisers",
    "Workshops",
    "Meetings and Networking",
    "Social Events",
    "Performing Arts"
  ]
end