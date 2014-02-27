FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end
  
  factory :activity do
    name "Thing to do"
    calories 1
  end

  factory :act do
    completed 1.day.ago
    minutes Random.rand(1..300)
    user
    activity
  end
end