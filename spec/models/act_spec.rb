require 'spec_helper'

describe Act do
  let(:user) { FactoryGirl.create(:complete_user) }
  let(:activity) { FactoryGirl.create(:activity) }

  before do
    @user_act = user.acts.build(
                completed: Time.now,
                minutes: 30,
                calories: calculate_calories(user, activity, 30),
                activity_id: activity.id)
    @activity_act = activity.acts.build(
                completed: Time.now,
                minutes: 30,
                calories: calculate_calories(user, activity, 30),
                user_id: user.id)
  end

  subject { @activity_act }

  it { should respond_to(:completed) }
  it { should respond_to(:minutes) }
  it { should respond_to(:calories) }
  it { should respond_to(:user_id) }
  it { should respond_to(:activity_id) }
  it { should respond_to(:activity) }
  its(:activity) { should eq activity }
  it { should be_valid }

  subject { @user_act }

  it { should respond_to(:completed) }
  it { should respond_to(:minutes) }
  it { should respond_to(:calories) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }
  it { should respond_to(:activity_id) }
  it { should be_valid }

  describe "when completed time is not present" do
    before { @user_act.completed = " " }
    it { should_not be_valid }
  end

  describe "when minute duration is not present" do
    before { @user_act.minutes = " " }
    it { should_not be_valid }
  end

  describe "when minute duration is not numerical" do
    before { @user_act.minutes = "a" }
    it { should_not be_valid }
  end

  describe "when minute duration is floating point" do
    before { @user_act.minutes = 1.1 }
    it { should_not be_valid }
  end

  describe "when minute duration is too low" do
    before { @user_act.minutes = 0 }
    it { should_not be_valid }
  end

  describe "when minute duration is too high" do
    before { @user_act.minutes = 301 }
    it { should_not be_valid }
  end

  describe "when user id is not present" do
    before { @user_act.user_id = nil }
    it { should_not be_valid }
  end

  describe "when activity id is not present" do
    before { @user_act.activity_id = " " }
    it { should_not be_valid }
  end

  describe "when calories is not present" do
    before { @user_act.calories = " " }
    it { should_not be_valid }
  end

  describe "when calories is not numerical" do 
    before { @user_act.calories = "blah" }
    it { should_not be_valid }
  end

  describe "when calories is too low" do
    before { @user_act.calories = 0 }
    it { should_not be_valid }
  end

  describe "when calories is not integral" do
    before { @user_act.calories = 35.6 }
    it { should_not be_valid }
  end
end
