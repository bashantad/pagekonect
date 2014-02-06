# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user_a = User.create({ full_name: "John Snow", email: "john@gmail.com", password: "password" })
user_b = User.create({ full_name: "Rob Stark", email: "rob@gmail.com", password: "password" })
user_c = User.create({ full_name: "Tyrin Lanister", email: "tyrin@gmail.com", password: "password" })

news1 = News.create({ user_id: 1, title:"LIVE: England finally lashes out", :description => "THEY struggled the whole way through, but England's batsmen managed to post a challenging target for Australia at the MCG", is_searchable: true })
news2 = News.create({ user_id: 1, title: "Poisoned water turns cities to ghost towns", description: "WEST Virginians noticed their water smelled like licorice. That's when authorities found a chemical spill so dangerous that 300,000 residents have gone without water for days.", is_searchable: true})
event1 = Event.create({ user_id:1, title: "Perth top place to be: NY Times", description: "PERTH has made the top 10 of The New York Times' list of 52 Places to Go in 2014.", is_searchable: true})
event2 = Event.create({ user_id: 1, title: "Test event ", description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat", is_searchable: true})
comment_a = news1.comments.create({ description: "Hurry!! I am just loving it", user: user_b })
comment_b = news2.comments.create({ description: "OMG!! it's horifying", user: user_c })
