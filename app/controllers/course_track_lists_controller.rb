class CourseTrackListsController < ApplicationController
  def index
  	@course_track_lists = CourseTrackList.joins(:course, :track)
  end

  def show
  	@course_track_list = CourseTrackList.joins(:course, :track).find params[:id]
  end

  def edit
  	@course_track_list = CourseTrackList.find params[:id]
  end

  def update
  	course_track_list = CourseTrackList.find params[:id]
  	if course_track_list.update_attributes(course_track_list_params)
  		redirect_to sys_admin_index_path, :notice => 'The course_track_list has successfully been updated.'
  	else
  		redirect_to :back, :notice => 'There was an error updating the course_track_list.'
  	end
  end

  def create
  	CourseTrackList.create(course_track_list_params)
  	redirect_to :back, :notice => 'The course_track_list has successfully been created.'
  end

  def destroy
  	CourseTrackList.destroy params[:id]
  	redirect_to :back, :notice => "The course_track_list has been removed."
  end

  private
  def course_track_list_params
  	params.require(:course_track_list).permit(:course_id, :track_id)
  end
end

