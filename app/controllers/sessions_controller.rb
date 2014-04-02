class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by_email(params[:session][:email].downcase)

		if user && user.authenticate(params[:session][:password])
			# Sign the user in and redirect to the user's show page.
			sign_in user
      		redirect_to user
		else
			flash.now[:error] = 'Invalid email/password combination' #flash.now : contents disappear after additional requests
			render 'new'
		end
	end
	
	def destroy
		sign_out
		redirect_to root_url
	end
end
