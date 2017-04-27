class Document < ActiveRecord::Base
	has_one :library
	has_one :offering, through: :library
	has_many :resources
	has_many :comments
	has_one :form
	#has_many :links

	
	filterrific(
		default_filter_params: { sorted_by: 'due_asc' },
		available_filters: [
			:sorted_by,
			:with_status,
			:with_formType,
			:with_offering_course_code_prefix,
			:with_offering_course_code_suffix,
			:with_offering_year,
			:with_offering_term,
			:with_offering_user_name,
			:with_offering_fname_and_lname
		]
	)

	scope :with_status, lambda { |statuses|
		if (statuses == [""])
			all
		else
			where(status: [*statuses])
		end
	}

	scope :with_formType, lambda { |formTypes|
		if (formTypes == [""])
			all
		else
			where(formType: [*formTypes])
		end
	}

	scope :with_offering_course_code_prefix, lambda { |prefix|
		if (prefix == [""])
			all
		else
			#where(code_prefix: [*prefix]).joins(offering: :course)
			where('code_prefix in (?)', prefix).joins(offering: :course)
		end
	}

	scope :with_offering_course_code_suffix, lambda { |suffix|
		if (suffix == [""])
			all
		else
			where('code_suffix in (?)', suffix).joins(offering: :course)
		end
	}

	scope :with_offering_year, lambda { |year|
		if (year == [""])
			all
		else
			where('year in (?)', year).joins(:offering)
		end
	}

	scope :with_offering_term, lambda { |term|
		if (term == [""])
			all
		else
			where('term in (?)', term).joins(:offering)
		end
	}

	scope :with_offering_user_name, lambda { |username|
		if (username == [""])
			all
		else
			where('users.name in (?)', username).joins(offering: :user)
		end
	}

  scope :with_offering_fname_and_lname, lambda { |names|
    if (names == [""])
      all
    else
      usernames = []
      @name_parts = names.first.split
      names.each do |n|
        usernames.push (User.find_by(fname: n.split.first,
                                    lname: n.split.last).name)
      end

      where('users.name in (?)', usernames).joins(offering: :user)
    end
  }


	scope :sorted_by, lambda { |sort_option|
		direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
		case sort_option.to_s
		when /^user_/
			order("users.name #{ direction }").includes(offering: :user)
		when /^assigned_/
			order("documents.assigned #{ direction }")
		when /^due_/
			order("documents.assigned #{ direction }")
		end
	}

	def self.options_for_sorted_by
    [
			['User (A-Z)', 'user_asc'],
			['User (Z-A)', 'user_desc'],
      ['Date Assigned (newest first)', 'assigned_desc'],
      ['Date Assigned (oldest first)', 'assigned_asc'],
			['Date Due (newest first)', 'due_desc'],
			['Date Due (oldest first)', 'due_asc']
    ]
  end

end
