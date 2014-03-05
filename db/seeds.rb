# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Activity.create!(name: "practice drums",
                heart_rate: 120)
Activity.create!(name: "lift weights", 
                heart_rate: 170)
Activity.create!(name: "run",
                heart_rate: 180)
Activity.create!(name: "do yoga",
                heart_rate: 165)
Activity.create!(name: "climb rocks",
                heart_rate: 165)
Activity.create!(name: "read Gravity's Rainbow",
                heart_rate: 80)
Activity.create!(name: "give a massage",
                heart_rate: 130)
Activity.create!(name: "teach yoga",
                heart_rate: 120)
Activity.create!(name: "study chess",
                heart_rate: 90)

Level.create!(number: 0, calorie_goal: 0, activity_goal: 0, title: "Novice")
Level.create!(number: 1, calorie_goal: 3500, activity_goal: 10, title: "Hot Potato")
Level.create!(number: 2, calorie_goal: 7000, activity_goal: 20, title: "Jumping Bean")
Level.create!(number: 3, calorie_goal: 10500, activity_goal: 30, title: "Animate Animal")
Level.create!(number: 4, calorie_goal: 14000, activity_goal: 40, title: "La Machina")