class Track < ActiveRecord::Base
  belongs_to :degree
	has_many :abet_outcomes, :dependent => :restrict_with_exception
	has_many :course_track_lists, :dependent => :restrict_with_exception
	has_many :courses, :through => :course_track_lists, :dependent => :restrict_with_exception
	has_many :approvers, :dependent => :restrict_with_exception
	has_many :users, :through => :approvers, :dependent => :restrict_with_exception
	has_one :master_matrix, :dependent => :restrict_with_exception

	##############
	# Validation #
	##############

	# A track's name should like "Systems Programming"
	# Force only first letter of each word to be Caps
	before_save {self.name = name.downcase}
	before_save { self.name = name.titleize }
	# Compress whitespace to single space
	before_save {self.name = name.gsub(/\s+/, ' ')}
	# name must only have letters, digits and space
	VALID_NAME_REGEX = /[A-Za-z0-9]*/
	# Force name to exist
	validates :name, presence: true, 
		format: { with: VALID_NAME_REGEX },
		uniqueness: { case_sensitive: false }

end
