require 'spec_helper'

describe Action do
  let(:user) { FactoryGirl.create(:user) }
  let(:activity) { FactoryGirl.create(:activity) }

  before do
    # This code is not idiomatically correct
    @action = Action.new(completed: Time.now,
                        user_id: user.id,
                        activity_id: activity.id)
  end

  subject { @action }

  it { should respond_to(:completed) }
  it { should respond_to(:user_id) }
  it { should respond_to(:activity_id) }
end
