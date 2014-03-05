require 'spec_helper'

describe Level do
  let(:user) { FactoryGirl.create(:complete_user) }

  before do
    # give this user several activities?
    # at a certain level? 
    @level = Level.first
    @new_level = Level.new(title: "Mega Awesome", calorie_goal: 50000, activity_goal: 60, number: 5)
  end

  subject { @level }

  it { should respond_to(:title) }
  it { should respond_to(:number) }
  it { should respond_to(:calorie_goal) }
  it { should respond_to(:activity_goal) }
  it { should be_valid } # it's already inserted, so isn't it valid?

  subject { @new_level }
  it { should respond_to(:title) }
  it { should respond_to(:number) }
  it { should respond_to(:calorie_goal) }
  it { should respond_to(:activity_goal) }
  it { should be_valid }

  describe "when title is not present" do
    before { @new_level.title = " " }
    it { should_not be_valid }
  end

  describe "when number is not unique" do
    before do
      Level.create!(title: "Mega Awesome", calorie_goal: 50000, activity_goal: 60, number: 5)
      @new_level.save
    end
    it { should_not be_valid }
  end

  describe "when title is fewer than three characters long" do
    before { @new_level.title = "ab" }
    it { should_not be_valid }
  end

  describe "when title is greater than 20 characters long" do
    before { @new_level.title = "a" * 21 }
    it { should_not be_valid }
  end

  describe "when number is not present" do
    before { @new_level.number = " " }
    it { should_not be_valid }
  end

  describe "when number is negative" do
    before { @new_level.number = -1 }
    it { should_not be_valid }
  end

  describe "when number is not numeric" do
    before { @new_level.number = "five" }
    it { should_not be_valid }
  end

  describe "when number is not integral" do
    before { @new_level.number = 5.4 }
    it { should_not be_valid }
  end

  describe "when calorie_goal is not present" do
    before { @new_level.calorie_goal = " " }
    it { should_not be_valid }
  end

  describe "when calorie_goal is negative" do
    before { @new_level.calorie_goal = -1 }
    it { should_not be_valid }
  end

  describe "when calorie_goal is not numeric" do
    before { @new_level.calorie_goal = "five" }
    it { should_not be_valid }
  end

  describe "when calorie_goal is not integral" do
    before { @new_level.calorie_goal = 5.4 }
    it { should_not be_valid }
  end

  describe "when activity_goal is not present" do
    before { @new_level.activity_goal = " " }
    it { should_not be_valid }
  end

  describe "when activity_goal is negative" do
    before { @new_level.activity_goal = -1 }
    it { should_not be_valid }
  end

  describe "when activity_goal is not numeric" do
    before { @new_level.activity_goal = "five" }
    it { should_not be_valid }
  end

  describe "when activity_goal is not integral" do
    before { @new_level.activity_goal = 5.4 }
    it { should_not be_valid }
  end
end
