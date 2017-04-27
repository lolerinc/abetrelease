class UserMailer < ApplicationMailer
	default from: 'abetcoordinatortamucc@gmail.com'

	def pass_email(user, pass)
		@user = user
		@pass = pass
		mail(to: @user.email, subject: "[TAMUCC ABET] Your new password")
	end

end
