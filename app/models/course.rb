class Course < ActiveRecord::Base
	has_many :offerings, :dependent => :restrict_with_exception
	has_many :course_track_lists, :dependent => :restrict_with_exception
	has_many :tracks, :through => :course_track_lists, :dependent => :restrict_with_exception
	has_many :master_matrices, :dependent => :restrict_with_exception
	has_many :abet_outcomes, :through => :master_matrices, :dependent => :restrict_with_exception

	##############
	# Validation #
	##############
		# Not implemented, but would be ideal to 
		# force unique on the code_prefix, code_suffix pair

	# name
	# Compress whitespace to single space
	before_save {self.name = name.gsub(/\s+/, ' ')}
	# name must only have letters, digits and space
  VALID_NAME_REGEX = /[A-Za-z0-9]*/
  # Force name to exist
  validates :name, presence: true,
    format: { with: VALID_NAME_REGEX },
    uniqueness: { case_sensitive: false }

	# code_prefix
	before_save { self.code_prefix = self.code_prefix.upcase }
	# Force alpha
	VALID_CODE_PREFIX_REGEX = /[A-Z]*/
	# Force existence
	validates :code_prefix, presence: true,
		format: {with: VALID_CODE_PREFIX_REGEX}

	# code_suffix
	# Force numeric
	# Force existence
	validates :code_suffix, presence: true,
		numericality: {only_integer: true}

	




end
