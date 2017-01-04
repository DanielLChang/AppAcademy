# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

todo0 = Todo.create!(
  title: "First Todo",
  body: "This is the first todo",
  done: false
)

todo1 = Todo.create!(
  title: "Second Todo",
  body: "I am the second todo",
  done: false
)
