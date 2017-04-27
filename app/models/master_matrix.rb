class MasterMatrix < ActiveRecord::Base
  belongs_to :track
  belongs_to :course
  belongs_to :abet_outcome


	filterrific(
		default_filter_params: {},
		available_filters: [
			:with_abet_outcome_track_name
		]
	)
    
    	scope :with_abet_outcome_track_name, lambda { |tracking|
		where('name = ?', tracking).joins(abet_outcome: :track)
	}
    
end