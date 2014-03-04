require 'spec_helper'

describe "User Pages" do
  subject { page }

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1, :per_page => 5).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end

    describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect do
            click_link('delete', match: :first)
          end.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end
  end

  describe "Signup page" do
    before { visit signup_path }

    it { should have_selector('h1', text: 'Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let(:different_user) { FactoryGirl.create(:user, name: "someone else", email: "someone_else@example.com") }
    let(:activity1) { FactoryGirl.create(:activity, name: "Activity 1") }
    let(:activity2) { FactoryGirl.create(:activity, name: "Activity 2") }
    let(:activity3) { FactoryGirl.create(:activity, name: "Activity 3") }
    let(:activity4) { FactoryGirl.create(:activity, name: "Activity 4") }
    let(:activity5) { FactoryGirl.create(:activity, name: "Activity 5") }
    let(:activity6) { FactoryGirl.create(:activity, name: "Activity 6") }

    let!(:a1) { FactoryGirl.create(:act, user: user, activity: activity1, completed: 1.week.ago, minutes: rand(1..300)) }
    let!(:a2) { FactoryGirl.create(:act, user: user, activity: activity2, completed: 5.days.ago, minutes: rand(1..300)) }

    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
    it { should have_content(user.acts.count) }

    it "should show acts via rendering the user's feed" do
      user.feed.each do |item|
        expect(page).to have_selector("li##{item.id}", text: item.activity.name)
        expect(page).to have_selector("li##{item.id}", text: item.activity.calories)
      end
    end

    describe "when the user is signed in" do
      before { sign_in user }

      it "should show delete links for the acts" do
        expect(page).to have_link('delete')
      end

      describe "followed by sign out" do
        before do 
          click_link 'Sign out'
          visit user_path(user)
        end

        it "should not show delete links for the acts" do
          expect(page).not_to have_link('delete')
        end
      end

      describe "viewing another user's profile" do
        before do
          click_link 'Sign out'
          sign_in different_user
          visit user_path(user)
        end

        it "should not show delete links for the acts" do
          expect(page).not_to have_link('delete')
        end
      end
    end      

    describe "should render the user's activity count" do
      it { should have_content("2 activities") }
    end

    describe "when the acts count is 1" do
      before do
        a1.destroy
        visit user_path(user)
      end

      describe "should not pluralize activities" do
        it { should have_content("1 activity") }
      end
    end

    describe "when the acts count is more than five" do
      before do
        FactoryGirl.create(:act, user: user, activity: activity3, completed: 5.days.ago, minutes: rand(1..300))
        FactoryGirl.create(:act, user: user, activity: activity4, completed: 4.days.ago, minutes: rand(1..300))
        FactoryGirl.create(:act, user: user, activity: activity5, completed: 3.days.ago, minutes: rand(1..300))
        FactoryGirl.create(:act, user: user, activity: activity6, completed: 2.days.ago, minutes: rand(1..300))
        visit user_path(user)
      end

      it "should show pagination" do
        expect(page).to have_selector("div.pagination")
      end
    end

    describe "when the current user views another user's profile page" do

      it "should not show delete links for the acts" do
        expect(page).not_to have_link('delete')
      end
    end
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title('Sign up') }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirm Password", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_title('') } # root page
        it { should have_selector('div', text: 'Welcome') }
        it { should have_link('Sign out', href: signout_path) } # test that it signs you in
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_email) { "new@example.com" }

      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(user.reload.name).to eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end

    describe "forbidden attributes" do
      let(:params) do
        { user: { admin: true, password: user.password,
                  password_confirmation: user.password } }
      end
      before do
        sign_in user, no_capybara: true
        patch user_path(user), params
      end
      specify { expect(user.reload).not_to be_admin }
    end
  end
end
