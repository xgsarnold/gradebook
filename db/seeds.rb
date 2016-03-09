# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

t1 = Teacher.create!(name: "Willie Jennings", email: "wj@mail.com", password: "mentor")
t2 = Teacher.create!(name: "Chuck Campbell", email: "cc@mail.com", password: "badass")

s1 = Student.create!(name: "Geoff Arnold", email: "geoff@mail.com", teacher: t1)
