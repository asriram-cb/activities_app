require 'spec_helper'

describe "Act pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "act creation" do
    before { visit root_path } # already here

    describe "with invalid information" do

      it "should not create an act" do
        expect { click_button "Do" }.not_to change(Act, :count)
      end

      describe "error messages" do
        before { click_button "Do" }
        it { should have_content('error') }
      end
    end

    # add test for valid informationin selenium

    describe "act destruction" do
      let(:act) { FactoryGirl.create(:activity, name: "something blah") }
      
      before { FactoryGirl.create(:act, user: user, activity: act, completed: Time.now, minutes: rand(1..300)) }

      describe "as correct user" do
        before { visit root_path } # already here

        it "should delete an act" do
          expect { click_link 'delete' }.to change(Act, :count).by(-1)
        end
      end
    end
  end
end
