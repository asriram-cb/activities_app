require 'spec_helper'

describe "Action pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "action creation" do
    before { visit root_url } # already here
    describe "with invalid information" do

      it "should not create an action" do
        expect { click_link "Do yoga!" }.not_to change(Action, :count)
      end

      describe "error messages" do
        before { click_link "Do yoga!" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'action_minutes', with: rand(1..300) }
      it "should create an action" do
        expect { click_link "Do yoga!" }.to change(Action, :count).by(1)
      end
    end
  end
end
