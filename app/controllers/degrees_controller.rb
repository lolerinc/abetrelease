class DegreesController < ApplicationController
  def index
  	@degrees = Degree.all
  end

  def show
  	@degree = Degree.find params[:id]
  end

  def edit
  	@degree = Degree.find params[:id]
  end

  def update
  	degree = Degree.find params[:id]
  	if degree.update_attributes(degree_params)
  		redirect_to sys_admin_index_path, :notice => 'The degree has successfully been updated.'
  	else
  		redirect_to :back, :notice => 'There was an error updating the degree.'
  	end
  end

  def create
  	Degree.create(degree_params)
  	redirect_to :back, :notice => 'The degree has successfully been created.'
  end

  def destroy
  	Degree.destroy params[:id]
  	redirect_to :back, :notice => "The degree has been removed."
  end

  private
  def degree_params
  	params.require(:degree).permit(:name)
  end
end
