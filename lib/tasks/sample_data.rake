namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    Activity.create!(name: "practice drums",
                    calories: 250)
    Activity.create!(name: "lift weights", 
                    calories: 500)
    Activity.create!(name: "run",
                    calories: 600)
    Activity.create!(name: "do yoga",
                    calories: 500)
    Activity.create!(name: "climb rocks",
                    calories: 700)
    Activity.create!(name: "read Gravity's Rainbow",
                    calories: 50)
    Activity.create!(name: "give a massage",
                    calories: 350)
    Activity.create!(name: "teach yoga",
                    calories: 200)
    Activity.create!(name: "study chess",
                    calories: 100)
    Action.create!(user_id: 1,
                  activity_id: 1,
                  completed: 3.days.ago)
    Action.create!(user_id: 1,
                  activity_id: 2,
                  completed: 2.days.ago)
    Action.create!(user_id: 1,
                  activity_id: 3,
                  completed: 1.day.ago)
    Action.create!(user_id: 2,
                  activity_id: 1,
                  completed: 2.days.ago)
    Action.create!(user_id: 2,
                  activity_id: 3,
                  completed: 18.hours.ago)
    Action.create!(user_id: 2,
                  activity_id: 4,
                  completed: 2.days.ago)
    Action.create!(user_id: 3,
                  activity_id: 5,
                  completed: 3.hours.ago)
    Action.create!(user_id: 3,
                  activity_id: 6,
                  completed: 4.hours.ago)
    Action.create!(user_id: 3,
                  activity_id: 7,
                  completed: 6.hours.ago)
    Action.create!(user_id: 4,
                  activity_id: 7,
                  completed: 2.hours.ago)
    Action.create!(user_id: 5,
                  activity_id: 8,
                  completed: 12.hours.ago)
    Action.create!(user_id: 5,
                  activity_id: 9,
                  completed: 8.hours.ago)
  end
end