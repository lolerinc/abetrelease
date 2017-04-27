class SessionsController < ApplicationController
	skip_before_filter :check_auth
	before_filter :no_double_login, :except => :destroy

  def new
  end

	def create
	  user = User.find_by(email: params[:session][:email].downcase)

		# Attempt authentication
		if user && user.authenticate(params[:session][:password])
			# If successful:
				log_in user
				redirect_to browse_index_url
		else  # Else if not successful
			flash.now[:danger] = 'Invalid Credentials.'
    	render 'new'
		end
	end

	def destroy
		log_out
		redirect_to root_url
	end
end
