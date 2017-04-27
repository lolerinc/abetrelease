class LibrariesController < ApplicationController
  def index
  	@libraries = Library.joins(:document, :offering => [:course])
  end

  def show
  	@library = Library.joins(:document, :offering => [:course]).find params[:id]
  end

  def edit
  	@library = Library.find params[:id]
  end

  def update
  	library = Library.find params[:id]
  	if library.update_attributes(library_params)
  		redirect_to sys_admin_index_path, :notice => 'The library has successfully been updated.'
  	else
  		redirect_to :back, :notice => 'There was an error updating the library.'
  	end
  end

  def create
  	Library.create(library_params)
  	redirect_to :back, :notice => 'The library has successfully been created.'
  end

  def destroy
  	Library.destroy params[:id]
  	redirect_to :back, :notice => "The library has been removed."
  end

  private
  def library_params
  	params.require(:library).permit(:offering_id, :document_id)
  end
end


