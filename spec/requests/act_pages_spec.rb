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
  end
end
