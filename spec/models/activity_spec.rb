require 'spec_helper'

describe Activity do
  
  let(:user) { FactoryGirl.create(:user) }
  before do
    # This code is not idiomatically correct
    @activity = Activity.new(name: "practice drums", user_id: user.id)
  end

  subject { @activity }

  it { should respond_to(:name) }
  it { should respond_to(:user_id) } # this isn't part of the table yet. made a relationship
end
