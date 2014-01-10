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

content = Content.create({ user: user_a })
comment_a = content.comments.create({ description: "hello john", user: user_b })
comment_b = content.comments.create({ description: "hello john snnoww", user: user_c })
