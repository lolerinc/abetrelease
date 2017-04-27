class UsersController < ApplicationController
	require 'securerandom'

  def index
  	@users = User.all
  end

  def show
  	@user = User.find params[:id]
  end

  def edit
  	@user = User.find params[:id]
  end

  def update
  	user = User.find params[:id]
  	if user.update_attributes(user_params)
  		redirect_to sys_admin_index_path, :notice => 'The user has successfully been updated.'
  	else
  		redirect_to :back, :notice => 'There was an error updating the user.'
  	end
  end

  def create
  	@usr = User.create(user_params)
		
		# Generate secure random password
		pass = SecureRandom.base64(12)
		@usr.update_attributes(password: pass, password_confirmation: pass)

		# Have the UserMailer send a welcome email
		UserMailer.pass_email(@usr, pass).deliver_now

		pass = 000000 #almost certainly useless, but an attempt to clear that variable

  	redirect_to :back, :notice => 'The user has successfully been created.'
  end

  def destroy
  	User.destroy params[:id]
  	redirect_to :back, :notice => "The user has been removed."
  end

  private
  def user_params
  	params.require(:user).permit(:name, :password, :fname, :lname, :email, :permission)
  end
end
