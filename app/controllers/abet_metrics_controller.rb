class AbetMetricsController < ApplicationController

	def evaluation
		@metric = AbetMetric.find params[:id]

		if (@metric.rating == "pass")
			@metric.update_attribute(:rating, "fail")	
		elsif (@metric.rating == "fail")
			@metric.update_attribute(:rating, "other")	
		elsif (@metric.rating == "other")
			@metric.update_attribute(:rating, "pass")	
		end

		redirect_to :back
	end

	def create
		AbetMetric.create(offering: Offering.find( params[:id] ), 
											abet: params[:abet], rating: "other")
		redirect_to :back
	end

	def destroy
		AbetMetric.destroy params[:id]
		redirect_to :back
	end



end
