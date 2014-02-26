include ApplicationHelper

RSpec::Matchers.define :have_error_message do |message|
	match do |page|
		expect(page).to have_selector('div.alert.alert-error', text: message)
	end
end

def sign_in(user, options={})
	if options[:no_capybara]
		# Sign in when not using Cabybara
		remember_token = User.new_remember_token
		cookies[:remember_token] = remember_token
		#post sessions_path, :email => user.email, :password => user.password
		#post sessions_path, {:session => { :email => user.email, :password => user.password }
		user.update_attribute(:remember_token, User.encrypt(remember_token))
	else
		visit signin_path
		fill_in "Email",	with: user.email
		fill_in "Password",	with: user.password
		click_button "Sign in"
	end
end
