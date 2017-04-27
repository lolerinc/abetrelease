class MasterMatricesController < ApplicationController
    

    
  def create
  
     @values = mastermatrix_params
     exists = 0
     msg = "Value has been added!"
     
     trackVal, courseVal, abetVal = @values.values_at :track_id, :course_id, :abet_outcome_id

     abetCheck = MasterMatrix.where(track_id: trackVal).where(course_id: courseVal).pluck(:abet_outcome_id)

     
     if MasterMatrix.where(track_id: trackVal).exists?(course_id: courseVal)
        exists +=1
     end
     
     if MasterMatrix.where(track_id: trackVal).where(course_id: courseVal).exists?(abet_outcome_id: abetVal) 
        exists +=1
     end
     
     if exists < 2
        @newData = MasterMatrix.new(mastermatrix_params)
        @newData.save
    else
        msg = "Value already exists!"
    
        
        
     end
    
    redirect_to master_matrices_index_path, alert: msg


  end  
  
  def delete
   MasterMatrix.find(params[:id]).destroy
   redirect_to master_matrices_index_path
end
  
  
  
   def mastermatrix_params
    params.require(:master_matrix).permit(:track_id, :course_id, :abet_outcome_id)
  end
  
  def index
   
    @newData = MasterMatrix.new
   
   
   
   	@filterrific = initialize_filterrific(

      MasterMatrix,
      params[:filterrific],
      select_options: {
      with_abet_outcome_track_name: Track.all.pluck('DISTINCT name')

      },
    ) or return

		@matrixinfo = @filterrific.find.page(params[:page])
      
		respond_to do |format|
      format.html
      format.js
        end

  rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return
  end
  
   
  
end
