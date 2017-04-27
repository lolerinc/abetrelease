class OfferingsController < ApplicationController
	include ApplicationHelper

	def index

		#########################
		# BEGIN filter handling #
		#########################

		@filterrific = initialize_filterrific(
			Offering,
			params[:filterrific],
			select_options: {
				with_course_code_prefix: Course.all.pluck('DISTINCT code_prefix'),
				with_course_code_suffix: Course.all.pluck('DISTINCT code_suffix'),
				#with_section,
				with_fname_and_lname: get_full_names,
				#with_evaluation,
				with_year: Offering.all.pluck('DISTINCT year')
			}
		) or return

		@offerings = @filterrific.find.page(params[:page]).paginate(page: params[:page], per_page: 20)
		@offerings = @offerings.includes(:user).where.not(users: {id: nil})

		respond_to do |format|
		  format.html
		  format.js
	end

	def reset_filterrific
	  #Clear session persistence
	  session[:filterrific] = nil
	  # Redirect back to the index action for default filter settings.
	  redirect_to action: :index
	end

	rescue ActiveRecord::RecordNotFound => e
		# There is an issue with the persisted param_set. Reset it.
		puts "Had to reset filterrific params: #{ e.message }"
		redirect_to(reset_filterrific_url(format: :html)) and return
	end

		#######################
		# END filter handling #
		#######################

	def view
		@offerings = Offering.joins(:course)
	end

	def show
		@offering = Offering.joins(:course).find params[:id]
	end

	def edit
		@offering = Offering.find params[:id]
	end

	def update
		offering = Offering.find params[:id]
		if offering.update_attributes(offering_params)
			redirect_to sys_admin_index_path, :notice => 'The offering has successfully been updated.'
		else
			redirect_to :back, :notice => 'There was an error updating the offering.'
		end
	end

	def create
		Offering.create(offering_params)
		redirect_to :back, :notice => 'The offering has successfully been created.'
	end

	def destroy
		Offering.destroy params[:id]
		redirect_to :back, :notice => "The offering has been removed."
	end



	# Function: evaluation
	# Purpose:
	# 	Changes the current evaluation status
	# 	Modifes 'offering.evaluation'
	# 	Cycles through the possible statuses
	
	def evaluation
	@offering = Offering.find params[:id]
		if (@offering.evaluation == "--")
			@offering.update_attribute(:evaluation, "Fail")
		elsif (@offering.evaluation == "Fail")
			@offering.update_attribute(:evaluation, "Pass")
		elsif (@offering.evaluation == "Pass")
			@offering.update_attribute(:evaluation, "Other")
		elsif (@offering.evaluation == "Other")
			@offering.update_attribute(:evaluation, "--")
		else
			@offering.update_attribute(:evaluation, "Fail")
		end

		redirect_to :back
	end


	private
	def offering_params
		params.require(:offering).permit(:CRN, :section, :year, :term, 
															:course_id, :evaluation)
	end



end

	# Function: GetColorFromEvaluation
	# Purpose:
	# 	Maps an evaluation status 
	# 	to its corrosponding color code

	def GetColorFromEvaluation(evaluation)
		evaluation = evaluation.downcase
		case evaluation
		when "pass"
			return "5cb85c"
		when "fail"
			return "d9534f"
		when "other"
			return "800080"
		else
			return "5bc0de"
		end
	end


