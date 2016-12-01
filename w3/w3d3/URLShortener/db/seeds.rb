# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ActiveRecord::Base.transaction do
  User.destroy_all
  u1 = User.create!(email: "cwhite@gmail.com")
  u2 = User.create!(email: "bwarford@gmail.com")

  Url.destroy_all
  su1 = Url.create_for_user_and_long_url!(
    u1, "www.google.com",
  )

  su2 = Url.create_for_user_and_long_url!(
    u2, "www.google2.com",
  )

  v1 = Visit.record_visit!(u1, su1)
  v2 = Visit.record_visit!(u1, su1)
  v3 = Visit.record_visit!(u1, su2)

  v4 = Visit.record_visit!(u2, su2)
  v5 = Visit.record_visit!(u2, su2)
  v6 = Visit.record_visit!(u2, su1)
end
