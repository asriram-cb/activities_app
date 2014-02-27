require 'spec_helper'

describe Activity do
  let(:user) { FactoryGirl.create(:user) } #unused

  before do
    # This code is not idiomatically correct
    @activity = Activity.new(name: "sleep", calories: 25)
  end

  subject { @activity }

  it { should respond_to(:name) }
  it { should respond_to(:calories) }
  it { should respond_to(:acts) }
  it { should respond_to(:users) }
  it { should be_valid }

  describe "when name is not present" do
    before { @activity.name = " " }
    it { should_not be_valid }
  end

  describe "when name is not unique" do
    before do
      Activity.create!(name: "sleep", calories: 25)
      @activity.save
    end
    it { should_not be_valid }
  end

  describe "when name is fewer than three characters long" do
    before { @activity.name = "ab" }
    it { should_not be_valid }
  end

  describe "when name is greater than 50 characters long" do
    before { @activity.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when calories is not present" do
    before { @activity.calories = " " }
    it { should_not be_valid }
  end

  describe "when calories is negative" do
    before { @activity.calories = -1 }
    it { should_not be_valid }
  end

  describe "when calories is not numerical" do
    before { @activity.calories = "four" }
    it { should_not be_valid }
  end

  describe "when calories is floating point" do
    before { @activity.calories = 1.1 }
    it { should_not be_valid }
  end
end
