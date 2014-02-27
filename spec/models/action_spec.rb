require 'spec_helper'

describe Action do
  let(:user) { FactoryGirl.create(:user) }
  let(:activity) { FactoryGirl.create(:activity) }

  before do
    @user_action = user.actions.build(
                completed: Time.now,
                activity_id: activity.id)
    @activity_action = activity.actions.build(
                completed: Time.now,
                user_id: user.id)
  end

  subject { @activity_action }

  it { should respond_to(:completed) }
  it { should respond_to(:user_id) }
  it { should respond_to(:activity_id) }
  it { should respond_to(:activity) }
  its(:activity) { should eq activity }
  it { should be_valid }

  subject { @user_action }

  it { should respond_to(:completed) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }
  it { should respond_to(:activity_id) }
  it { should be_valid }

  describe "when completed time is not present" do
    before { @user_action.completed = " " }
    it { should_not be_valid }
  end

  describe "when user id is not present" do
    before { @user_action.user_id = " " }
    it { should_not be_valid }
  end

  describe "when activity id is not present" do
    before { @user_action.activity_id = " " }
    it { should_not be_valid }
  end
end
