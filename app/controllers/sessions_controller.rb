class SessionsController < ApplicationController

  # sessions_path via GET
  def index
  end

  # new_session_path via GET
	def new
	end

  # sessions_path via POST
	def create 
=begin
		#form_tag version
		user = User.find_by(email: params[:email].downcase)
    	
    	if user && user.authenticate(params[:password])
      		sign_in user
      		redirect_to user
    	else
      		flash.now[:error] = 'Invalid email/password combination'
      		render 'new'
    	end
=end
    	# form_for version
    	user = User.find_by(email: params[:session][:email].downcase)
    	
    	if user && user.authenticate(params[:session][:password])
      		sign_in user
      		redirect_back_or user
    	else
      		flash.now[:error] = 'Invalid email/password combination'
      		render 'new'
    	end
	end

	def destroy
		sign_out
		redirect_to root_url 
    # why not root_path?
    # because Each of these helpers has a corresponding _url helper (such as photos_url) which returns the same path prefixed with the current host, port and path prefix.
	end
end
