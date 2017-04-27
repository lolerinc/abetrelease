class AbetOutcomesController < ApplicationController
  def index
  	@abet_outcomes = AbetOutcome.joins(:track).all
  end

  def show
  	@abet_outcome = AbetOutcome.joins(:track).find params[:id]
  end

  def edit
  	@abet_outcome = AbetOutcome.find params[:id]
  end

  def update
  	abet_outcome = AbetOutcome.find params[:id]
  	if abet_outcome.update_attributes(abet_outcome_params)
  		redirect_to sys_admin_index_path, :notice => 'The abet_outcome has successfully been updated.'
  	else
  		redirect_to :back, :notice => 'There was an error updating the abet_outcome.'
  	end
  end

  def create
  	AbetOutcome.create(abet_outcome_params)
  	redirect_to :back
  end

  def destroy
  	AbetOutcome.destroy params[:id]
  	redirect_to :back, :notice => "The abet_outcome has been removed."
  end

  private
  def abet_outcome_params
  	params.require(:abet_outcome).permit(:track_id, :code, :desc)
  end
end
