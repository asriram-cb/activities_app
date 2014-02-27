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

    users = User.all(limit: 6)
    15.times do |n|
      act_id = rand(1..Activity.count)
      completed = Time.now - n.days
      users.each { |user| user.acts.create!(completed: completed,
                                              minutes: rand(1..300),
                                              activity_id: act_id) }
    end
  end
end