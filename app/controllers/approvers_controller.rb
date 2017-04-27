class ApproversController < ApplicationController
  def index
  	@approvers = Approver.joins(:user, :track)
  end

  def show
  	@approver = Approver.joins(:user, :track).find params[:id]
  end

  def edit
  	@approver = Approver.find params[:id]
  end

  def update
  	approver = Approver.find params[:id]
  	if approver.update_attributes(approver_params)
  		redirect_to sys_admin_index_path, :notice => 'The approver has successfully been updated.'
  	else
  		redirect_to :back, :notice => 'There was an error updating the approver.'
  	end
  end

  def create
  	Approver.create(approver_params)
  	redirect_to :back, :notice => 'The approver has successfully been created.'
  end

  def destroy
  	Approver.destroy params[:id]
  	redirect_to :back, :notice => "The approver has been removed."
  end

  private
  def approver_params
  	params.require(:approver).permit(:user_id, :track_id)
  end
end
