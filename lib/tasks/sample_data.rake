namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true,
                 age: rand(1..120),
                 weight: rand(1..500),
                 gender: ['male', 'female'].sample)
    9.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   age: rand(1..120),
                   weight: rand(1..500),
                   gender: ['male', 'female'].sample)
    end
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

    users = User.all
    7.times do |n|
      act_id = rand(1..Activity.count)
      completed = Time.now - n.days
      minutes = rand(1..300)
      activity = Activity.find(act_id)

      users.each do |user|
        calories = user.gender == "female" ? ( (user.age * 0.074) - (user.weight * 0.05741) + (activity.heart_rate * 0.4472) - 20.4022) * minutes / 4.184 : ( (user.age * 0.2017) + (user.weight * 0.09036) + (activity.heart_rate * 0.6309) - 55.0969) * minutes / 4.184
        calories = calories.round(0) < 1 ? 1 : calories.round(0)
        user.acts.create!(completed: completed,
                          minutes: minutes,
                          calories: calories,
                          activity_id: act_id)
      end
    end
  end
end