class DocumentsController < ApplicationController
	include ApplicationHelper

  def index

	usr = ''
	if (current_user.permission == 'I')
		usr = current_user.name
		default_statuses = ['Not Submitted', 'Revisions Required']
	elsif (current_user.permission == 'C' || current_user.permission == 'A')
		default_statuses = ['Not Reviewed']
	end

	@filterrific = initialize_filterrific(
      Document,
      params[:filterrific],
      select_options: {
        sorted_by: Document.options_for_sorted_by,
				with_offering_user_name: User.all.pluck('DISTINCT name'),
				with_offering_fname_and_lname: get_full_names,
        with_status: Document.all.pluck('DISTINCT status'),
        		with_id: Document.all.pluck('DISTINCT id'), # Added to get and pass row id of clicked to docview, not printed.
				with_formType: Document.all.pluck('formType'),
				with_offering_course_code_prefix: Course.all.pluck('DISTINCT code_prefix'),
				with_offering_course_code_suffix: Course.all.pluck('DISTINCT code_suffix'),
				with_offering_term: Offering.all.pluck('DISTINCT term'),
				with_offering_year: Offering.all.pluck('DISTINCT year')
      },
      default_filter_params: { :with_offering_user_name => usr,
																:with_status => default_statuses,
														:sorted_by => 'due_asc'},
    ) or return

		@documents = @filterrific.find.page(params[:page]).paginate(page: params[:page], per_page: 20)
		@documents = @documents.includes(:offering).where.not(offerings: {id: nil})
		@documents = @documents.includes(offering: :user).where.not(users: {id: nil})
		
		respond_to do |format|
      format.html
      format.js
    end

		def reset_filterrific
			#Clear session persistence
			session[:filterrific] = nil
		  # Redirect back to the index action for default filter settings.
			redirect_to action: :index
		end

  rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return
  end

  def update
  	document = Document.find_by(id: params[:doc_id])
  	if document.update(status: "Not Reviewed")
  		redirect_to :back #Add notice
  	else
  		redirect_to :back #Add error
  	end
  end

	def update_status
		document = Document.find_by(id: params[:doc_id])
		document.update(status: params[:new_status])
		redirect_to :back
	end

  def docview
  	@data = Document.joins(:offering => [:course, :user]).where("documents.id = ?", params[:row_id])
  end

  	def all
		@documents = Document.joins(:offering => [:course, :user])
	end

	def show
		@document = Document.joins(:offering => [:course, :user]).find params[:id]
	end

	def edit
		@document = Document.find params[:id]
	end

	def update
		document = Document.find params[:id]
		if document.update_attributes(document_params)
			redirect_to sys_admin_index_path, :notice => 'The document has successfully been updated.'
		else
			redirect_to :back, :notice => 'There was an error updating the document.'
		end
	end

	def create
		Document.create(document_params)
		redirect_to :back, :notice => 'The document has successfully been created.'
	end

	def destroy
		Document.destroy params[:id]
		redirect_to :back, :notice => "The document has been removed."
	end

	private
	def document_params
		params.require(:document).permit(:name, :status, :assigned, :due, :formType)
	end
end
