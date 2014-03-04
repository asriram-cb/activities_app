FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end

    factory :complete_user do
      age 30
      weight 115
      gender "female"
    end
  end
  
  factory :activity do
    name "Thing to do"
    heart_rate 150
  end

  factory :act do
    completed 1.day.ago
    minutes Random.rand(1..300)
    calories 600
    user
    activity
  end
end