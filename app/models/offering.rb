class Offering < ActiveRecord::Base
  belongs_to :course
	has_many :libraries
	has_many :documents, :through => :libraries
	has_one :teaching
	has_one :user, :through => :teaching
	has_many :AbetMetrics

	##############
	# Validation #
	##############

	# CRN
	# Force numeric, existence, unique
	validates :CRN, presence: true,
		numericality: {only_integer: true},
		uniqueness: { case_sensitive: false }
	
	# section
	# Force numeric, existence
	validates :section, presence: true,
		numericality: {only_integer: true}

	# year
		## Not yet: should also force an actual year
	# Force numeric
	# Force existence
	validates :year, presence: true,
		numericality: {only_integer: true}

	# term
	# Force numeric, existence
	validates :term, presence: true,
		numericality: {only_integer: true}

	# evaluation
	# Force either 'Pass', 'Fail', 'Other', 'Null'
	#validates :evaluation, presence: true,
	#	:inclusion => ["Pass", "Fail", "Other", "--"]

	# course
	# Force existence
	validates :course, presence: true

	#####################
	# START FILTERRIFIC #
	#####################

	# All in this section is used for filters
	# in the Tracker page

	filterrific(
		default_filter_params: { },
		available_filters: [
			:with_course_code_prefix,
			:with_course_code_suffix, 
			#:with_section,
			:with_fname_and_lname,
			#:with_evaluation,
			:with_year
		]
	)

		scope :with_year, lambda { |years| 
			if (years == [""])
				all
			else
				where(year: [*years])
			end
		}

		scope :with_course_code_prefix, lambda { |prefix|
			if (prefix == [""])
				all
			else
				where('code_prefix in (?)', prefix).joins(:course)
			end
		}

		scope :with_course_code_suffix, lambda { |suffix|
			if (suffix == [""])
				all
			else
				where('code_suffix in (?)', suffix).joins(:course)
			end
		}

		scope :with_fname_and_lname, lambda { |names|
			if (names == [""])
				all
			else
				usernames = []
				@name_parts = names.first.split
				names.each do |n|
					usernames.push (User.find_by(fname: n.split.first, 
																			lname: n.split.last).name)
				end

				where('users.name in (?)', usernames).joins(:user)
			end
		}

	###################
	# END FILTERRIFIC #
	###################
end
