module SessionsHelper

  # User Log in
	def log_in(user)
	  session[:user_id] = user.id
	end
	
	# User Log out
	def log_out
		session.delete(:user_id)
		@current_user = nil
	end

	# Returns the currently logged-in user
	# or 'nil' if there is none
	def current_user
		@current_user ||= User.find_by(id: session[:user_id])
	end

	# Returns true if the user is logged in, false otherwise
	def logged_in?
		!current_user.nil?
	end

 def get_user_type_string
    if logged_in?
      case current_user.permission
      when "I"
        return "Instructor"
      when "C"
        return "Coordinator"
      when "A"
        return "Administator"
      when "E"
        return "Evaluator"
      else
        return ""
      end
    else
      ""
    end
  end



end
