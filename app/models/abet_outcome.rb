class AbetOutcome < ActiveRecord::Base
  belongs_to :track
	has_many :master_matrices, :dependent => :restrict_with_exception
	has_many :courses, :through => :master_matrices, :dependent => :restrict_with_exception


	##############
	# VALIDATION #
	##############

  # desc
  # Compress whitespace to single space
  before_save {self.desc = desc.gsub(/\s+/, ' ')}
  # Force name to exist
  validates :desc, presence: true
end


