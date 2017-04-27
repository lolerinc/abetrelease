class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	include SessionsHelper

	before_filter :check_auth

	protected
	def check_auth
		if !logged_in?
			if(request.path != root_url)
				redirect_to root_url
				flash[:danger] = "Not authorized to view. Please log in."
			end
		end
	end

	def no_double_login
		if logged_in?
			redirect_to browse_index_url
		end
	end

end
