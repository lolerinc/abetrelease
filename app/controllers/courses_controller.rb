class CoursesController < ApplicationController
  def index
  	@courses = Course.all
  end

  def show
  	@course = Course.find params[:id]
  end

  def edit
  	@course = Course.find params[:id]
  end

  def update
  	course = Course.find params[:id]
  	if course.update_attributes(course_params)
  		redirect_to sys_admin_index_path, :notice => 'The course has successfully been updated.'
  	else
  		redirect_to :back, :notice => 'There was an error updating the course.'
  	end
  end

  def create
  	Course.create(course_params)
  	redirect_to :back
  end

  def destroy
  	Course.destroy params[:id]
  	redirect_to :back, :notice => "The course has been removed."
  end

  private
  def course_params
  	params.require(:course).permit(:name, :code_suffix, :code_prefix)
  end
end
