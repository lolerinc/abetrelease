class TracksController < ApplicationController
  def index
  	@tracks = Track.joins(:degree)
  end

  def show
  	@track = Track.joins(:degree).find params[:id]
  end

  def edit
  	@track = Track.joins(:degree).find params[:id]
  end

  def update
  	track = Track.find params[:id]
  	if track.update_attributes(track_params)
  		redirect_to sys_admin_index_path, :notice => 'The track has successfully been updated.'
  	else
  		redirect_to :back, :notice => 'There was an error updating the track.'
  	end
  end

  def create
  	Track.create(track_params)
  	redirect_to :back, :notice => 'The track has successfully been created.'
  end

  def destroy
  	Track.destroy params[:id]
  	redirect_to :back, :notice => "The track has been removed."
  end

  private
  def track_params
  	params.require(:track).permit(:degree_id, :name)
  end
end
