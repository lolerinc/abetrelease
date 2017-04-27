class SysAdminController < ApplicationController
	before_filter :gatekeeper

  def index

    # These are used to pull the rows that will be 
    # shown in the sys_config view 

    # Each has two lines. 
    # The first line loads the data, and
    # the second adds functionality from the 
    # "pagination" gem which makes it to where
    # only N rows are shown per page, with a navigation bar

    @abet_outcomes = AbetOutcome.joins(:track)
      @abet_outcomes = @abet_outcomes.paginate(:page => params[:abet_outcomes_page], :per_page => 10)
    @airs = AIR.all
      @airs = @airs.paginate(:page => params[:airs_page], :per_page => 10)
    @course_track_lists = CourseTrackList.joins(:track, :course)
      @course_track_lists = @course_track_lists.paginate(:page => params[:course_track_listspage], :per_page => 10)
    @courses = Course.all
      @courses = @courses.paginate(:page => params[:courses_page], :per_page => 10)
    @degrees = Degree.all
      @degrees = @degrees.paginate(:page => params[:degrees_page], :per_page => 10)
    @documents = Document.joins(:offering => [:course, :user])
      @documents = @documents.paginate(:page => params[:documents_page], :per_page => 10)
    @eocms = EOCM.all
      @eocms = @eocms.paginate(:page => params[:eocms_page], :per_page => 10)
    @libraries = Library.joins(:document, :offering => [:course])
      @libraries = @libraries.paginate(:page => params[:libraries_page], :per_page => 10)
    @offerings = Offering.joins(:course)
      @offerings = @offerings.paginate(:page => params[:offerings_page], :per_page => 10)
    @pies = PIE.all
      @pies = @pies.paginate(:page => params[:pies_page], :per_page => 10)
    @teachings = Teaching.joins(:user, :offering => [:course])
      @teachings = @teachings.paginate(:page => params[:teachings_page], :per_page => 10)
    @tracks = Track.joins(:degree)
      @tracks = @tracks.paginate(:page => params[:tracks_page], :per_page => 10)
    @users = User.all
      @users = @users.paginate(:page => params[:users_page], :per_page => 10)

    # Tables not being used in admin console

      # Tables modified elsewhere in system
    #@abet_metrics = AbetMetric.all
    #@master_matrices = MasterMatrix.all

      # Tables that will be added in the future
    #@approvers = Approver.joins(:user, :track)
    #@authors = Author.all
    #@comments = Comment.all
    #@course_outcomes = CourseOutcome.all
    #@resources = Resource.all
    #@uploaders = Uploader.all


  end

	# Function: gatekeeper
	# Purpose: Ensure visitors to any sys config views
	# are admins or coordinators
	def gatekeeper
		if (current_user.permission != "C" && current_user.permission != "A")
			redirect_to root_path
		end
	end


  def show
  end
end

