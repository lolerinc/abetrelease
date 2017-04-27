class TeachingsController < ApplicationController
  def index
  	@teachings = Teaching.joins(:user, :offering => [:course])
  end

  def show
  	@teaching = Teaching.joins(:user, :offering => [:course]).find params[:id]
  end

  def edit
  	@teaching = Teaching.find params[:id]
  end

  def update
  	teaching = Teaching.find params[:id]
  	if teaching.update_attributes(teaching_params)
  		redirect_to sys_admin_index_path, :notice => 'The teaching has successfully been updated.'
  	else
  		redirect_to :back, :notice => 'There was an error updating the teaching.'
  	end
  end

  def create
  	Teaching.create(teaching_params)
  	redirect_to :back, :notice => 'The teaching has successfully been created.'
  end

  def destroy
  	Teaching.destroy params[:id]
  	redirect_to :back, :notice => "The teaching has been removed."
  end

  private
  def teaching_params
  	params.require(:teaching).permit(:user_id, :offering_id)
  end
end
