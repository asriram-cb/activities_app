require 'spec_helper'

describe "Static pages" do
  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading)       { 'Life is Amazing' }
    let(:page_title)    { '' }

    it_should_behave_like "all static pages"
    it { should_not have_title('| Home') }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      let(:activity1) {FactoryGirl.create(:activity, name: "new activity1") }
      let(:activity2) {FactoryGirl.create(:activity, name: "new activity2") }

      before do
        FactoryGirl.create(:act, user: user, activity: activity1, completed: Time.now, minutes: rand(1..300))
        FactoryGirl.create(:act, user: user, activity: activity2, completed: Time.now, minutes: rand(1..300))
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.activity.name)
        end
      end

      it "should render the user's activity count" do
        expect(page).to have_content("2 activities")
      end

      describe "when the count is 1" do
        before do
          user.acts[0].destroy
          visit root_path
        end

        it "should not pluralize activities" do
          expect(page).to have_content("1 activity")
        end
      end
    end
  end
   
  describe "Help page" do
    before { visit help_path }
    let(:heading)       { 'Help' }
    let(:page_title)    { 'Help' }

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }
    let(:heading)       { 'About Us' }
    let(:page_title)    { 'About Us' }

    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }
    let(:heading)       { 'Contact' }
    let(:page_title)    { 'Contact' }

    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title('About Us'))
    click_link "Help"
    expect(page).to have_title(full_title('Help'))
    click_link "Contact"
    expect(page).to have_title(full_title('Contact'))
    click_link "Home"
    click_link "Sign up now!"
    expect(page).to have_title(full_title('Sign up'))
    click_link "life is amazing"
    expect(page).to have_title(full_title(''))
  end
end