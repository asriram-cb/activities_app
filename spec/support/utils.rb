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
		user.update_attribute(:remember_token, User.encrypt(remember_token))
	else
		visit signin_path
		fill_in "Email",	with: user.email
		fill_in "Password",	with: user.password
		click_button "Sign in"
	end
end

 def calculate_calories(user, activity, minutes)
 	if complete_user?(user)
	  cal = user.gender == "female" ? ( (user.age * 0.074) - (user.weight * 0.05741) + (activity.heart_rate * 0.4472) - 20.4022) * minutes / 4.184 : ( (user.age * 0.2017) + (user.weight * 0.09036) + (activity.heart_rate * 0.6309) - 55.0969) * minutes / 4.184
	  # taken from http://fitnowtraining.com/2012/01/formula-for-calories-burned/
	  cal.round(0)
	else 
		1
	end
end

def complete_user?(user)
	!user.age.blank? && !user.weight.blank? && !user.gender.blank?
end