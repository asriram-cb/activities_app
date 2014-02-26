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
end
