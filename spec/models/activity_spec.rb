require 'spec_helper'

describe Activity do
  let(:user) { FactoryGirl.create(:user) } #unused

  before do
    # This code is not idiomatically correct
    @activity = Activity.new(name: "sleep", heart_rate: 50)
  end

  subject { @activity }

  it { should respond_to(:name) }
  it { should respond_to(:heart_rate) }
  it { should respond_to(:acts) }
  it { should respond_to(:users) }
  it { should be_valid }

  describe "when name is not present" do
    before { @activity.name = " " }
    it { should_not be_valid }
  end

  describe "when name is not unique" do
    before do
      Activity.create!(name: "sleep", heart_rate: 50)
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

  describe "when heart_rate is not present" do
    before { @activity.heart_rate = " " }
    it { should_not be_valid }
  end

  describe "when heart_rate is negative" do
    before { @activity.heart_rate = -1 }
    it { should_not be_valid }
  end

  describe "when heart_rate is less than 50" do
    before { @activity.heart_rate = 49 }
    it { should_not be_valid }
  end

  describe "when heart_rate is not numerical" do
    before { @activity.heart_rate = "four" }
    it { should_not be_valid }
  end

  describe "when heart_rate is floating point" do
    before { @activity.heart_rate = 50.1 }
    it { should_not be_valid }
  end
end
