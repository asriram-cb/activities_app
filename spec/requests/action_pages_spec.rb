require 'spec_helper'

describe "Action pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "action creation" do
    #before { visit root_path } # already here
    describe "with invalid information" do

      it "should not create an action" do
        expect { click_button "Do yoga!" }.not_to change(Action, :count)
      end

      describe "error messages" do
        before { click_button "Do yoga!" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      it "should create an action" do
      end
    end
  end
end
